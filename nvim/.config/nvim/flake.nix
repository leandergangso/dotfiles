{
  description = "Toolchain for Neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems =
        f:
        builtins.listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) systems
        );
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          editorTools = pkgs.buildEnv {
            name = "nvim-editor-tools";
            paths = with pkgs; [
              gopls
              lua-language-server
              vscode-langservers-extracted
              svelte-language-server
              tailwindcss-language-server
              typescript-language-server
              stylua
              prettier
              tinymist
              websocat
            ];
            pathsToLink = [ "/bin" ];
            ignoreCollisions = true;
          };
        in
        {
          inherit editorTools;
          editor-tools = editorTools;
          default = editorTools;
          gopls = pkgs.gopls;
          lua-language-server = pkgs.lua-language-server;
          vscode-langservers-extracted = pkgs.vscode-langservers-extracted;
          svelte-language-server = pkgs.svelte-language-server;
          tailwindcss-language-server = pkgs.tailwindcss-language-server;
          typescript-language-server = pkgs.typescript-language-server;
          stylua = pkgs.stylua;
          prettier = pkgs.prettier;
          tinymist = pkgs.tinymist;
          websocat = pkgs.websocat;
        }
      );
    };
}
