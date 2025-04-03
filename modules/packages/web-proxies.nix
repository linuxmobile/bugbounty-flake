{pkgs}:
with pkgs; [
  # Proxies
  mitmproxy
  proxychains
  proxify

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
]
