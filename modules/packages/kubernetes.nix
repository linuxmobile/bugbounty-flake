# Kubernetes infrastructure
{pkgs}:
with pkgs; [
  cfripper
  # checkov (isn't building)
  cirrusgo
  kdigger
  kube-hunter
  kube-score
  kubeaudit
  kubestroyer
  kubescape
  popeye
]
