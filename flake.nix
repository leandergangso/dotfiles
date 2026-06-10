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
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "global-packages";
        paths = with pkgs; [
          zsh
          yay
          git
          curl
          wget
          htop
          btop
          stow
          ncdu
          zoxide
          oh-my-posh
          #base-devel
          i3
          i3lock
          go
          go-task
          neovim
          docker
          docker-compose
          podman
          podman-compose
          brave
          localsend
        ];
      };
    };
}
