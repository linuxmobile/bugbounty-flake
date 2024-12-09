{pkgs}: let
  reconScript = import ./recon.nix {inherit pkgs;};
  scanScript = import ./scan.nix {inherit pkgs;};
  setupScript = import ./setup.nix {inherit pkgs;};
in [
  reconScript
  scanScript
  setupScript
]
