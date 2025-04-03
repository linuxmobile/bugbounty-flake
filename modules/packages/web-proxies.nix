{pkgs}:
with pkgs; [
  # Proxies
  mitmproxy
  proxychains
  proxify
  bettercap
  ettercap
  mubeng
  redsocks
  rshijack

  # Traffic Analysis
  tcpdump
  termshark
  dsniff
  netsniff-ng
  ngrep

  # Request Manipulation
  httpie
  curl
  hey
  xh
  hurl
  wuzz
  monsoon
]
