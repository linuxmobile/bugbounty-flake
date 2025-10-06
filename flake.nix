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
            segger-jlink.acceptLicense = true;
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
              httpx
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
            # All package modules automatically included
            ++ builtins.attrValues modules.packages
            ++ modules.scripts;

          shellHook = ''

            export NUCLEI_TEMPLATES="${pkgs.nuclei-templates}/share/nuclei-templates"
            export WORDLISTS="${pkgs.wordlists}/share/wordlists"
            export DIRBUSTER="${pkgs.dirbuster}/share/dirbuster"
            export SECLISTS="${pkgs.seclists}/share/wordlists/seclists"
            export MEDIUM="${pkgs.seclists}/share/wordlists/seclists/Discovery/Web-Content/raft-medium-directories.txt"
            export SMALL="${pkgs.seclists}/share/wordlists/seclists/Discovery/Web-Content/raft-small-directories.txt"
            export API="${pkgs.seclists}/share/wordlists/seclists/Discovery/Web-Content/api/api-endpoints-res.txt"
            export ROCKYOU="${pkgs.wordlists}/share/wordlists/rockyou.txt"
          '';
        };

        _module.args.modules = modules;
      };
    };
}
