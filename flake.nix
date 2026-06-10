# NOTE: avoid system level packages in NIX, let Arch pacman/yay handle those.
{
  description = "Global User Packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      shellUtils = with pkgs; [
        jq
        fd
        age
        zsh
        git
        bat
        fzf
        stow
        tree
        btop
        ncdu
        stow
        yazi
        procs
        dogdns
        zoxide
        ripgrep
        fastfetch
        oh-my-posh
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
        neovim
        #docker
        #docker-compose
        #podman
        #podman-compose
      ];

      programs = with pkgs; [
        brave
        localsend
      ];

      fonts = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "global-packages";
        paths = shellUtils ++ windowManager ++ devTools ++ programs ++ fonts;
      };
    };
}
