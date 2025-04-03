{pkgs}:
with pkgs; [
  # Traffic Analysis
  tcpdump
  termshark
  # wireshark - removing as it's GUI-based

  # Network Testing
  socat
  netcat-gnu

  # Data Processing
  anew
  unfurl

  # Out-of-band Testing
  interactsh

  # Networking Utilities
  bind
  whois
]
