{pkgs}:
with pkgs; [
  # DNS Tools
  bind
  whois

  # Networking Utilities
  socat
  netcat-gnu
  ipcalc
  netmask

  # Out-of-band Testing
  interactsh
]
