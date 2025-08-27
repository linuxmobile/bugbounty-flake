{pkgs}:
with pkgs; [
  # Password Cracking
  hashcat
  john
  hashid
  nth
  phrasendrescher
  brutespray
  conpass
  legba
  nasty
  # ncrack - package bricked
  truecrack

  # Wordlist Generation
  crunch

  # Secret Scanning
  gitleaks
  trufflehog
  secretscanner
  detect-secrets
  whispers
  bomber-go
  tell-me-your-secrets
  gitxray
]
