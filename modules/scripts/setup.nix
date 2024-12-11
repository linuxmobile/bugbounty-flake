{pkgs}:
pkgs.writeScriptBin "setup-bugbounty" ''
  #!${pkgs.stdenv.shell}

  # Create necessary directories
  mkdir -p $HOME/bugbounty/{reconnaissance,scans,reports}

  echo "Bug Bounty directories created at ~/bugbounty/"
''
