# Code analysing tools, incl. search for secrets and alike in code
{pkgs}:
with pkgs; [
  bomber-go
  cargo-audit
  credential-detector
  # deepsecrets
  detect-secrets
  freeze
  # garble
  git-secret
  gitjacker
  gitleaks
  gitls
  gitxray
  gokart
  # legitify (pkg broken)
  osv-detector
  packj
  # pip-audit (don't build)
  # python314Packages.safety (don't build)
  secretscanner
  skjold
  tell-me-your-secrets
  trufflehog
  whispers
  xeol
]
