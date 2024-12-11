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
            jq
            ripgrep
            skim
            wget
            parallel
            go
            python3

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
          export NUCLEI_TEMPLATES_PATH="${pkgs.nuclei-templates}/share/nuclei-templates"

          echo "🎯 Bug Bounty Environment Loaded!"
          echo "Run 'setup-bugbounty' to start the environment"
        '';
      };

      inherit modules;
    });
}
