{pkgs}:
with pkgs; [
  # Directory and File Brute Forcing
  ffuf # Fast web fuzzer
  feroxbuster # Fast content discovery tool
  gobuster # Directory/file & DNS busting tool
  dirb # Web content scanner
  wfuzz # Web application fuzzer

  # Web Crawling and Spidering
  gospider # Fast web spider
  hakrawler # Web crawler for URLs and JS files
  katana # Advanced crawler and spider
  meg # Fetch many paths for many hosts

  # Parameter Discovery
  # arjun           # HTTP parameter discovery suite - not in nixpkgs

  # Javascript Analysis
  subjs # Find JavaScript files from domains
  jsluice # Extract URLs, endpoints from JavaScript
  # xnlinkfinder    # JavaScript endpoint extractor - not in nixpkgs

  # Historical Data
  gau # Get All URLs from OTX, Wayback, etc.
  # waybackurls     # Not in nixpkgs - fetch URLs from Wayback Machine

  # Payload Injection and Testing
  qsreplace # Query string replacement tool
  crlfuzz # CRLF vulnerability scanner
  kiterunner # API discovery tool

  # Custom wordlists
  seclists # Collection of security wordlists
]
