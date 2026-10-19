{
  # init:       nix profile add ~/.dotfiles
  # profile:    nix profile upgrade --all --refresh
  # update:     nix flake update --refresh
  # template:   nix flake init -t ~/.dotfiles#default

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      #ols-nightly = import ./flakes/ols.nix { inherit pkgs; };
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "tools";

        paths = with pkgs; [
          # custom
          #ols-nightly

          # nix
          nil
          nixfmt

          # utils
          age
          bat
          brave
          fd
          figlet
          fzf
          git
          go-task
          jq
          neovim
          ripgrep
          tailwindcss_4
          tree
          tree-sitter
          yazi
          yq
          zoxide

          # lang
          go
          zig
          odin
          pnpm
          nodejs
          python3
          typescript

          # lsp
          astro-language-server
          bash-language-server
          dockerfile-language-server
          emmet-ls
          gopls
          zls # zig
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
