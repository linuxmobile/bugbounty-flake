{pkgs}:
with pkgs; [
  # DNS & Subdomain Enumeration
  amass
  subfinder
  dnsx
  massdns
  assetfinder
  dnsrecon
  fierce
  knockpy
  altdns
  findomain
  aiodnsbrute
  dnstwist
  dnsvalidator
  subzerod
  # subprober - this re write the httpx package
  puredns

  # Network Discovery
  nmap
  masscan
  rustscan
  naabu
  arp-scan
  zmap

  # Service Identification
  tlsx
  httpx
  whatweb
  wafw00f
  wad
  webanalyze

  # OSINT Tools
  theharvester
  recon-ng
  maigret
  socialscan
  # holehe - this re write the httpx package
  urlhunter
  metabigor

  # Historical Data
  gau
  waybackurls # not in nixpkgs
]
