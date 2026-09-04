{
  # run: nix profile add ~/.dotfiles/nix

  description = "Personal global tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.buildEnv {
        name = "global-tools";

        paths = with pkgs; [
          # nix
          nixd # alt: nil
          nixfmt-rfc-style

          # utils
          brave
          neovim
          bat
          fd
          fzf
          jq
          yq
          ripgrep
          zoxide
        ];
      };
    };
}
