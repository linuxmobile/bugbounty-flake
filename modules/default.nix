{
  pkgs,
  system,
}: {
  packages = {
    # Core bug bounty packages
    reconnaissance = import ./packages/reconnaissance.nix {inherit pkgs;};
    vulnScanning = import ./packages/vulnerability-scanning.nix {inherit pkgs;};
    webProxies = import ./packages/web-proxies.nix {inherit pkgs;};
    apiTesting = import ./packages/api-testing.nix {inherit pkgs;};
    contentDiscovery = import ./packages/content-discovery.nix {inherit pkgs;};
    codeAnalysis = import ./packages/code-analysis.nix {inherit pkgs;};

    # Additional package categories
    passwordSecrets = import ./packages/password-secrets.nix {inherit pkgs;};
    exploitation = import ./packages/exploitation.nix {inherit pkgs;};
    dataProcessing = import ./packages/data-processing.nix {inherit pkgs;};
    networkUtils = import ./packages/network-utils.nix {inherit pkgs;};
    fuzzing = import ./packages/fuzzing.nix {inherit pkgs;};
    activeDirect = import ./packages/active-directory.nix {inherit pkgs;};
    tunneling = import ./packages/tunneling.nix {inherit pkgs;};
    webScreenshot = import ./packages/web-screenshot.nix {inherit pkgs;};
    # cloudSecurity = import ./packages/cloud-security.nix {inherit pkgs;};
    # mobileSecurity = import ./packages/mobile-security.nix {inherit pkgs;};
    # forensics = import ./packages/forensics.nix {inherit pkgs;};
  };

  scripts = import ./scripts {
    inherit pkgs;
  };

  software = {
    zellijConfig = import ./software/zellij.nix {inherit pkgs;};
  };
}
