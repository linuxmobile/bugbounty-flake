{pkgs}:
with pkgs; [
  # Secret Scanning
  gitleaks # Git repo secret scanner
  trufflehog # Advanced secret scanner

  # Static Analysis
  semgrep # Static analysis tool

  # Password Tools
  hashcat # Password recovery tool
  john # John the Ripper password cracker
  hashid # Identify hash types
  medusa # Parallel network authentication brute-forcing tool
]
