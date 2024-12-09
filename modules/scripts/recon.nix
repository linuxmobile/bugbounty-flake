{pkgs}:
pkgs.writeScriptBin "recon-subdomain" ''
  #!${pkgs.stdenv.shell}

  if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
  fi

  domain=$1
  output_dir="$HOME/bugbounty/reconnaissance/$domain"

  mkdir -p "$output_dir"

  echo "[+] Starting subdomain enumeration for $domain"

  # Run subfinder
  ${pkgs.subfinder}/bin/subfinder -d "$domain" -o "$output_dir/subfinder.txt"

  # Run amass
  ${pkgs.amass}/bin/amass enum -d "$domain" -o "$output_dir/amass.txt"

  # Combine and sort unique results
  cat "$output_dir"/*.txt | sort -u > "$output_dir/all_subdomains.txt"

  echo "[+] Found $(wc -l < "$output_dir/all_subdomains.txt") unique subdomains"
  echo "[+] Results saved in $output_dir"
''
