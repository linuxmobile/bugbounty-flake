{
  pkgs,
  system,
}: {
  packages = {
    reconnaissance = import ./packages/reconnaissance.nix {inherit pkgs;};
    vulnScanning = import ./packages/vulnerability-scanning.nix {inherit pkgs;};
    webProxies = import ./packages/web-proxies.nix {inherit pkgs;};
    apiTesting = import ./packages/api-testing.nix {inherit pkgs;};
    networkAnalysis = import ./packages/network-analysis.nix {inherit pkgs;};
    contentDiscovery = import ./packages/content-discovery.nix {inherit pkgs;};
    codeAnalysis = import ./packages/code-analysis.nix {inherit pkgs;};
  };

  scripts = import ./scripts {
    inherit pkgs;
  };

  software = {
    zellijConfig = import ./software/zellij.nix {inherit pkgs;};
  };
}
