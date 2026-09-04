{
  # init:   nix profile add ~/.dotfiles
  # update: nix flake upgrade --all

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "tools";

        paths = with pkgs; [
          nil
          nixfmt

          # utils
          bat
          brave
          btop
          fastfetch
          fd
          figlet
          fzf
          git
          go-task
          jq
          neovim
          ripgrep
          tree
          tree-sitter
          yazi
          yq
          zoxide

          # lang
          go
          pnpm
          python3

          # formatter
          prettier
          stylua
        ];
      };

      # use: nix flake init -t ~/.dotfiles#default
      templates = {
        default = {
          path = ./templates/default;
          description = "Standard development environment template";
        };
      };
    };
}
