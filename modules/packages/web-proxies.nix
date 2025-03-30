{pkgs}:
with pkgs; [
  # Proxies
  mitmproxy # Interactive TLS-capable proxy
  proxychains # Force TCP traffic through proxy

  # Request Manipulation
  httpie # Modern HTTP client
  curl # URL retrieval utility
  hey # HTTP load testing tool
  xh # Friendly HTTP client
]
