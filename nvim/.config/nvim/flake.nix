{
  description = "Neovim toolchain";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      cliTools = with pkgs; [
        bash-language-server
        shellcheck
        tree-sitter
        websocat
      ];

      languageServers = with pkgs; [
        gopls
        lua-language-server
        nil
        prettier
        stylua
        svelte-language-server
        tailwindcss-language-server
        typescript-language-server
        vscode-langservers-extracted
      ];
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "nvim-editor-tools";
        paths = cliTools ++ languageServers;
        pathsToLink = [ "/bin" ];
        ignoreCollisions = true;
      };
    };
}
