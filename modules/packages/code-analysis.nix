{pkgs}:
with pkgs; [
  gitleaks    # Scan git repos for secrets and keys
  trufflehog  # Advanced secret scanner with regex and entropy
  hashcat     # Advanced password recovery and cracking tool
  john        # John the Ripper password cracker
  semgrep     # Static analysis tool for finding bugs and vulnerabilities
]
