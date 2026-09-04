{
  # init:       nix profile add ~/.dotfiles
  # update:     nix flake upgrade --all
  # template:   nix flake init -t ~/.dotfiles#default

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

          # lsp
          astro-language-server
          bash-language-server
          dockerfile-language-server
          emmet-ls
          gopls
          hyprls
          lua-language-server
          vscode-langservers-extracted
          ols # odin
          pyright
          svelte-language-server
          systemd-lsp
          tailwindcss-language-server
          taplo # TOML toolkit
          templ
          tinymist
          tofu-ls
          typescript-language-server
          yaml-language-server

          # formatter
          black
          isort
          prettier
          stylua
        ];
      };

      templates = {
        default = {
          path = ./templates/default;
          description = "Standard development environment template";
        };
      };
    };
}
