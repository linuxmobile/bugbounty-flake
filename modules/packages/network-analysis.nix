{pkgs}:
with pkgs; [
  # Traffic Analysis
  tcpdump # Network packet analyzer
  termshark # Terminal-based Wireshark

  # Network Testing
  socat # Multipurpose relay tool
  netcat # TCP/IP swiss army knife

  # Cloud Services Testing
  # cloudhunter # AWS resource discovery
  # s3scanner # S3 bucket scanner
  # awscli # AWS command line interface

  # Data Processing
  anew # Tool for adding new lines to files
  unfurl # Extract and analyze domains from URLs

  # Out-of-band Testing
  interactsh # OOB payload testing tool

  # Networking Utilities
  bind # DNS tools like dig, host, nslookup
  whois # Domain registration info
]
