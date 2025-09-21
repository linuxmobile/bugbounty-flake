# Host security tools
{pkgs}:
with pkgs; [
  checksec
  # chkrootkit (removed as unmaintained)
  linux-exploit-suggester
  lynis
  safety-cli
  tracee
  vulnix
]
