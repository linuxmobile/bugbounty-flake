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
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      modules = import ./modules {
        inherit pkgs system;
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            zellij
          ]
          ++ modules.packages.reconnaissance
          ++ modules.packages.vulnScanning
          ++ modules.packages.webProxies
          ++ modules.packages.apiTesting
          ++ modules.packages.networkAnalysis
          ++ modules.packages.contentDiscovery
          ++ modules.packages.codeAnalysis
          ++ modules.scripts;

        shellHook = ''
          export ZELLIJ_CONFIG_FILE=${modules.software.zellijConfig.config}
          export ZELLIJ_CONFIG_DIR=${modules.software.zellijConfig.layoutDir}

          echo "🎯 Bug Bounty Environment Loaded!"
          echo "Run 'setup-bugbounty' to start the environment"
        '';
      };

      inherit modules;
    });
}
