{pkgs}:
with pkgs; [
  gitleaks # Scan git repos for secrets and keys
  hashcat # Advanced password recovery and cracking tool
  john # John the Ripper password cracker
  medusa # Parallel network authentication brute-forcing tool
  semgrep # Static analysis tool for finding bugs and vulnerabilities
  trufflehog # Advanced secret scanner with regex and entropy
]
