{pkgs}:
with pkgs; [
  # Static Analysis
  semgrep
  osv-scanner
  skjold
  gokart
  brakeman
  cargo-audit
  osv-detector
  xeol

  # Credential Detection
  credential-detector
  h8mail
  git-secret
  gitjacker
  gitls
  legitify
  pip-audit
]
