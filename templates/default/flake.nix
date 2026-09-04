{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          git
        ];

        env = {
          KEY = "value";
        };

        shellHook = ''
          echo "--- Default ENV ---"

          if [ -f .env ]; then
            echo "Loading .env file..."
            export $(xargs < .env)
          fi
        '';
      };
    };
}
