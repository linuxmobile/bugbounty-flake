{pkgs}: let
  zellij = import ../software/zellij.nix {inherit pkgs;};
in
  pkgs.writeScriptBin "setup-bugbounty" ''
    #!${pkgs.stdenv.shell}

    # Create necessary directories
    mkdir -p $HOME/bugbounty/{reconnaissance,scans,reports}

    # Detect and set the correct shell
    if command -v zsh >/dev/null 2>&1; then
      export SHELL=$(command -v zsh)
    elif command -v fish >/dev/null 2>&1; then
      export SHELL=$(command -v fish)
    elif command -v bash >/dev/null 2>&1; then
      export SHELL=$(command -v bash)
    fi

    echo "Using shell: $SHELL"

    # Start zellij with our custom config and layout
    SHELL=$SHELL ${pkgs.zellij}/bin/zellij \
      --config ${zellij.config} \
      --layout ${zellij.layoutDir}/layouts/bug-bounty.kdl
  ''
