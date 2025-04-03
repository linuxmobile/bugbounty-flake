{pkgs}:
with pkgs; [
  # AWS
  cloudfox
  # prowler - this re write the httpx package
  pacu
  cloudlist
  cliam
  ec2stepshell
  goblob

  # Azure
  azurehound
  go365
  offensive-azure

  # Multi-Cloud
  cloud-nuke
  grimoire
  yatas
  terrascan
  chain-bench
  gcp-scanner
  # poutine - package bricked
  witness
]
