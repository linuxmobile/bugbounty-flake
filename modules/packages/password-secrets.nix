{pkgs}:
with pkgs; [
  # Password Cracking
  hashcat
  john
  hashid
  nth
  phrasendrescher

  # Wordlist Generation
  crunch

  # Secret Scanning
  gitleaks
  trufflehog
  secretscanner
  detect-secrets
  whispers
  bomber-go
  deepsecrets
  tell-me-your-secrets
]
