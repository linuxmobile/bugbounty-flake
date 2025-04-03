{pkgs}:
with pkgs; [
  # DNS Tools
  bind
  whois
  dnspeep
  dnstracer

  # Traffic Analysis
  tcpdump
  termshark

  # Data Processing
  anew
  unfurl

  # Networking Utilities
  socat
  netcat-gnu
  ipcalc
  netmask
  arping
  cdncheck
  iperf2
  mtr
  nload
  nuttcp
  pingu
  rustcat
  sshping

  # Out-of-band Testing
  interactsh
]
