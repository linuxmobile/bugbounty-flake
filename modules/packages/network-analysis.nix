{pkgs}:
with pkgs; [
  interactsh  # Out-of-band payload testing tool
  cdncheck    # Check if IPs belong to known CDN ranges
  cloudhunter # AWS public resources discovery
  s3scanner   # Scan for open S3 buckets
  anew        # Tool for adding new lines to files
  unfurl      # Extract and analyze domains from URLs
  netcat      # TCP/IP swiss army knife
  socat       # Multipurpose relay tool
  tcpdump     # Network packet analyzer
  sslscan     # Test SSL/TLS enabled services
  whois       # Query domain registration and ownership info
]
