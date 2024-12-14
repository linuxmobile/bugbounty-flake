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
        overlays = [
          (final: prev: import ./pkgs {pkgs = prev;})
        ];
      };

      modules = import ./modules {
        inherit pkgs system;
      };
    in {
      packages = import ./pkgs {inherit pkgs;};

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            zellij
            jq
            ripgrep
            skim
            wget
            parallel
            moreutils
            inetutils
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
          export WORDLISTS="${pkgs.wordlists}/share/wordlists"
          export DIRBUSTER="${pkgs.dirbuster}/share/wordlists"
        '';
      };

      inherit modules;
    });
}
