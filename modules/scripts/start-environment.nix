{pkgs}:
pkgs.writeScriptBin "start-environment" ''
  #!${pkgs.stdenv.shell}
  set -e  # Exit on error

  # Function to detect shell
  detect_shell() {
    if [ -f "/etc/profiles/per-user/$USER/bin/zsh" ]; then
      echo "/etc/profiles/per-user/$USER/bin/zsh"
    elif [ -f "/run/current-system/sw/bin/zsh" ]; then
      echo "/run/current-system/sw/bin/zsh"
    elif [ -f "/usr/bin/zsh" ]; then
      echo "/usr/bin/zsh"
    else
      echo "$SHELL"
    fi
  }

  # Set shell
  export SHELL=$(detect_shell)
  echo "Using shell: $SHELL"

  # Verify environment variables
  echo "Config file: $ZELLIJ_CONFIG_FILE"
  echo "Layout dir: $ZELLIJ_CONFIG_DIR"

  # Function to start or attach to zellij session
  start_session() {
    ${pkgs.zellij}/bin/zellij

    # Check for existing session
    if ${pkgs.zellij}/bin/zellij list-sessions 2>/dev/null | grep -q "bugbounty"; then
      echo "Attaching to existing session..."
      exec ${pkgs.zellij}/bin/zellij attach bugbounty
    else
      echo "Starting new session..."
      exec ${pkgs.zellij}/bin/zellij \
        --config "$ZELLIJ_CONFIG_FILE" \
        --layout "$ZELLIJ_CONFIG_DIR/layouts/bug-bounty.kdl" \
        --session bugbounty
    fi
  }

  # Main execution
  if [ -z "$ZELLIJ" ]; then
    echo "Starting zellij session..."
    start_session
  else
    echo "Already in a zellij session"
  fi
''
