# Password and hashing tools
{pkgs}:
with pkgs; [
  authoscope
  bruteforce-luks
  brutespray
  conpass
  crunch
  h8mail
  (hashcat.override {rocmSupport = true;})
  hashcat-utils
  hashdeep
  john
  keepassxc
  keepassxc-go
  legba
  medusa
  nasty
  ncrack
  nth
  oath-toolkit
  phrasendrescher
  # python314Packages.patator (don't build)
  thc-hydra
  truecrack
  seclists
  wordlists
]
