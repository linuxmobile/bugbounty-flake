# Common network tools
{pkgs}:
with pkgs; [
  arp-scan
  arp-scan-rs
  arping
  arpoison
  atftp
  bandwhich
  bngblaster
  cdncheck
  evillimiter
  iperf2
  iputils
  lftp
  mdns-scanner
  # mitm6 (check later)
  mtr
  ncftp
  netcat-gnu
  netdiscover
  netexec
  nload
  nuttcp
  # pingu (check later)
  putty
  pwnat
  responder
  route-graph
  rustcat
  sshping
  sslh
  # tunnelgraf (isn't building)
  wbox
  whois
  yersinia
]
