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
  mx-takeover
  wtfis
  dnsmon-go
  dnstake

  # Network Discovery
  nmap
  masscan
  rustscan
  naabu
  arp-scan
  zmap
  das
  udpx
  sx-go

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
  enumerepo
  cloudbrute
  # p0f - package bricked

  # Historical Data
  gau
  waybackurls # not in nixpkgs
]
