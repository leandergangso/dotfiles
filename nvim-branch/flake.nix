{
  description = "User tools and Neovim runtime dependencies";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      cliTools = with pkgs; [
        age
        bat
        btop
        doggo
        fastfetch
        fd
        fzf
        jq
        ncdu
        oh-my-posh
        procs
        ripgrep
        tree
        yazi
        zoxide
      ];

      devTools = with pkgs; [
        go
        go-task
        neovim
        pnpm
      ];

      neovimTools = with pkgs; [
        gopls
        lua-language-server
        prettier
        stylua
        svelte-language-server
        tailwindcss-language-server
        tinymist
        typescript
        typescript-language-server
        vscode-langservers-extracted
        websocat
      ];
    in
    {
      packages.${system} = {
        neovim-tools = pkgs.buildEnv {
          name = "neovim-tools";
          paths = neovimTools;
        };

        default = pkgs.buildEnv {
          name = "dotfiles-user-tools";
          paths = cliTools ++ devTools ++ neovimTools;
        };
      };
    };
}
