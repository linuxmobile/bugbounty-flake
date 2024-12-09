{
  description = "Bug Bounty Hunter Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      modules = import ./modules {
        inherit pkgs system;
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            zellij
          ]
          ++ modules.packages.recon
          ++ modules.packages.exploit
          ++ modules.packages.webTools
          ++ modules.scripts;

        shellHook = ''
          export ZELLIJ_CONFIG_FILE=${modules.software.zellijConfig}

          echo "🎯 Bug Bounty Environment Loaded!"
        '';
      };

      inherit modules;
    });
}
