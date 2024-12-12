{ pkgs }:
with pkgs; [
  ffuf         # Fast web fuzzer for directory/file discovery
  feroxbuster  # Fast content discovery tool written in Rust
  gobuster     # Directory/file & DNS busting tool
  gospider     # Fast web spider for discovering links and assets
  hakrawler    # Web crawler for gathering URLs and JavaScript files
  gau          # Get All URLs - Fetch known URLs from AlienVault's OTX
  crlfuzz      # Fast tool to scan CRLF vulnerability
  subjs        # Find JavaScript files from domains and URLs
  jsluice      # Extract URLs, endpoints, and secrets from JavaScript
  meg          # Tool for fetching many paths for many hosts
  arjun        # HTTP parameter discovery suite
  qsreplace    # Query string replacement tool
  katana       # Crawling and spidering framework for web security testing

  # kxss         # Blind XSS injection tool
  paramspider  # Mining parameters from dark corners of Web Archives
  waybackurls  # Fetch URLs from Wayback Machine
]
