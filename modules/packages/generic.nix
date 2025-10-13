# Generic tools (terminals, packers, clients, etc.)
{pkgs}:
with pkgs; [
  chrony
  clamav
  curl
  cyberchef
  dnsutils # dig, nslookup
  dorkscout
  easyeasm
  exiflooter
  file
  findutils
  flashrom
  girsh
  gtfocli
  helix
  htop
  httpie
  # hurl (isn't building)
  inetutils
  inxi
  iproute2
  iputils # ping, traceroute, arping, etc.
  iw
  less
  lsof
  lynx
  macchanger
  net-tools # ifconfig, netstat, route, etc.
  openssl
  parted
  procps # ps, top, free, etc.
  pwgen
  ronin
  spyre
  strace
  utillinux
  wget
  which
  xh

  # Monitoring
  btop
  iftop
  iotop

  # Terminal helpers
  eternal-terminal
  mosh
  shellz
  rlwrap

  # Common client for various protocols
  certinfo-go
  cifs-utils
  freerdp
  net-snmp
  nfs-utils
  ntp
  openssh
  openvpn
  samba
  step-cli
  wireguard-go
  wireguard-tools
  xrdp

  # Network design helpers
  ipcalc
  netmask

  # Terminal multiplexer
  zellij

  # Archive tools
  cabextract
  p7zip
  unrar
  unzip

  python3
  python313Packages.pip
  python313Packages.impacket
  git
]
