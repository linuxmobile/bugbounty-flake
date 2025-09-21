# Generic tools (terminals, packers, clients, etc.)
{pkgs}:
with pkgs; [
  chrony
  clamav
  curl
  cyberchef
  dorkscout
  easyeasm
  exiflooter
  flashrom
  girsh
  gtfocli
  httpie
  # hurl (isn't building)
  inetutils
  inxi
  iproute2
  iw
  lynx
  macchanger
  helix
  parted
  pwgen
  ronin
  spyre
  utillinux
  wget
  xh
  iputils # ping, traceroute, arping, etc.
  procps # ps, top, free, etc.
  htop
  lsof
  strace
  which
  file
  less
  findutils
  net-tools # ifconfig, netstat, route, etc.
  dnsutils # dig, nslookup

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
  git
]
