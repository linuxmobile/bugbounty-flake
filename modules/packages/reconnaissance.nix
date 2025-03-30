{pkgs}:
with pkgs; [
  # DNS and Subdomain Enumeration
  amass # Advanced subdomain enumeration
  subfinder # Passive subdomain discovery
  dnsx # Fast DNS toolkit
  massdns # High-performance DNS stub resolver
  puredns # Not in nixpkgs - fast domain resolver
  assetfinder # Find domains and subdomains
  # sublist3r # Fast subdomains enumeration tool
  dnsrecon # DNS reconnaissance tool
  fierce # DNS analysis tool
  knockpy # Subdomain scanner
  altdns # Subdomain discovery through permutations

  # Network Scanning
  nmap # Network exploration and security auditing
  masscan # TCP port scanner
  rustscan # Modern port scanner
  naabu # Fast port scanner

  # Service Identification
  tlsx # TLS grabber and analyzer
  httpx # Fast HTTP probing
  whatweb # Next generation web scanner
  wafw00f # Web Application Firewall detector

  # OSINT Tools
  theharvester # Email, subdomain, and people names harvester
  recon-ng # Web reconnaissance framework

  # Data Processing
  gron # Make JSON greppable
  jq # JSON processor
  yq # YAML/XML processor
  htmlq # Like jq but for HTML
]
