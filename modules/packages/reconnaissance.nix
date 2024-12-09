{pkgs}:
with pkgs; [
  amass       # In-depth DNS enumeration and network mapping
  subfinder   # Fast passive subdomain discovery tool
  dnsx        # Fast DNS toolkit
  massdns     # High-performance DNS stub resolver
  nmap        # Network exploration and security auditing
  masscan     # TCP port scanner
  rustscan    # Modern port scanner
  tlsx        # TLS grabber and analyzer
  httpx       # Fast HTTP probing with multiple features
  whatweb     # Next generation web scanner
  assetfinder # Find domains and subdomains
  knockpy     # Subdomain scanner

  # puredns     # Fast domain resolver and subdomain bruteforcing
  # findomain   # Cross-platform subdomain enumerator
]
