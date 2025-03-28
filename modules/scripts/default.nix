{pkgs}: let
  wordlists = import ./wordlists.nix {inherit pkgs;};
in [
  wordlists
]
