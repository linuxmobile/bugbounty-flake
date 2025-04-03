{pkgs}:
with pkgs; [
  # Static Analysis
  semgrep
  osv-scanner
  skjold
  gokart
  brakeman

  # Credential Detection
  credential-detector
  h8mail
]
