# FIX: broken custom ols binary

{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "ols";
  version = "unstable";

  src = pkgs.fetchFromGitHub {
    owner = "DanielGavin";
    repo = "ols";
    rev = "master";
    hash = "sha256-/1ZqUc1RN7uav2hfCrb1EKw67EvXPZgKBYyd0NqRgLA="; # clear to update to latest version
  };

  nativeBuildInputs = [
    pkgs.odin
    pkgs.git
  ];

  buildPhase = ''
    # prevent build.sh from trying to use git
    export OLS_VERSION="nix-unstable"

    patchShebangs ./build.sh ./odinfmt.sh
    ./build.sh
    ./odinfmt.sh
  '';

  installPhase = ''
    install -Dm755 ols $out/bin/ols
    install -Dm755 odinfmt $out/bin/odinfmt
  '';
}
