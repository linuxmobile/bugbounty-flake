{
  description = "Bug Bounty Hunter Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: let
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
            # Original modules
            ++ modules.packages.reconnaissance
            ++ modules.packages.vulnScanning
            ++ modules.packages.webProxies
            ++ modules.packages.apiTesting
            ++ modules.packages.contentDiscovery
            ++ modules.packages.codeAnalysis
            # Additional modules
            ++ modules.packages.passwordSecrets
            ++ modules.packages.exploitation
            ++ modules.packages.dataProcessing
            ++ modules.packages.networkUtils
            ++ modules.packages.fuzzing
            ++ modules.packages.activeDirect
            ++ modules.packages.tunneling
            ++ modules.packages.webScreenshot
            # ++ modules.packages.cloudSecurity
            # ++ modules.packages.mobileSecurity
            # ++ modules.packages.forensics
            ++ modules.scripts;

          shellHook = ''
            export ZELLIJ_CONFIG_FILE=${modules.software.zellijConfig.config}
            export ZELLIJ_CONFIG_DIR=${modules.software.zellijConfig.layoutDir}
            export NUCLEI_TEMPLATES="${pkgs.nuclei-templates}/share/nuclei-templates"
            export WORDLISTS="${pkgs.wordlists}/share/wordlists"
            export DIRBUSTER="${pkgs.dirbuster}/share/dirbuster"
            export SECLISTS="${pkgs.seclists}/share/wordlists/seclists"

            mkdir -p temp
            echo "Created temporary workspace directory at ./temp"
          '';
        };

        _module.args.modules = modules;
      };
    };
}
