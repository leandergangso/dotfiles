{
  description = "Global user packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      shellUtils = with pkgs; [
        age
        bat
        btop
        doggo
        fd
        fastfetch
        fzf
        git
        jq
        ncdu
        oh-my-posh
        procs
        ripgrep
        stow
        tree
        yazi
        zoxide
        zsh
      ];

      windowManager = with pkgs; [
        #i3
        #i3lock
        feh
        rofi
        dunst
        #polybar
        flameshot
      ];

      devTools = with pkgs; [
        go
        go-task
        pnpm
        #docker
        #docker-compose
        #podman
        #podman-compose
      ];

      programs = with pkgs; [
        localsend
      ];

      fonts = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "global-tools";
        paths = shellUtils ++ windowManager ++ devTools ++ programs ++ fonts;
        pathsToLink = [ "/bin" ];
        ignoreCollisions = true;
      };
    };
}
