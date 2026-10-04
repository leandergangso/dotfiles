{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "ols";
  version = "unstable";

  src = pkgs.fetchFromGitHub {
    owner = "DanielGavin";
    repo = "ols";
    rev = "e67f5803fe923a16d4741aa6f6a65c961af37b22"; # nightly commit
    hash = "sha256-r8nNvO4PhQo5KmjER2ZmoFdYDL8aSGx4Hr0xyDzhkss="; # pkgs.lib.fakeHash
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
