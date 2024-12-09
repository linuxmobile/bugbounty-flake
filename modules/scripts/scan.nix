{pkgs}:
pkgs.writeScriptBin "scan-vulnerabilities" ''
  #!${pkgs.stdenv.shell}

  if [ -z "$1" ]; then
    echo "Usage: $0 <targets_file>"
    exit 1
  fi

  targets_file=$1
  output_dir="$HOME/bugbounty/scans/$(date +%Y%m%d)"

  mkdir -p "$output_dir"

  echo "[+] Starting vulnerability scan"

  # Run nuclei
  ${pkgs.nuclei}/bin/nuclei -l "$targets_file" \
    -severity critical,high \
    -o "$output_dir/nuclei_results.txt"

  # Run httpx for service detection
  ${pkgs.httpx}/bin/httpx -l "$targets_file" \
    -title -tech-detect -status-code \
    -o "$output_dir/httpx_results.txt"

  echo "[+] Scan complete. Results saved in $output_dir"
''
