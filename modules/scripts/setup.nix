{pkgs}: let
  zellij = import ../software/zellij.nix {inherit pkgs;};
in
  pkgs.writeScriptBin "setup-bugbounty" ''
    #!${pkgs.stdenv.shell}

    # Create necessary directories
    mkdir -p $HOME/bugbounty/{reconnaissance,scans,reports}

    # Start zellij with our custom config and layout
    ${pkgs.zellij}/bin/zellij \
      --config ${zellij.config} \
      --layout ${zellij.layout}
  ''
