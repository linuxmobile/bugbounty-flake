{pkgs}:
with pkgs; [
  # AWS
  cloudfox
  # prowler - this re write the httpx package
  pacu
  cloudlist
  cliam

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
]
