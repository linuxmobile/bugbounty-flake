{ pkgs }:

{
  waybackurls = pkgs.callPackage ./waybackurls { };
  puredns = pkgs.callPackage ./puredns { };
  jwt-tool = pkgs.callPackage ./jwt-tool { };
  paramspider = pkgs.callPackage ./paramspider { };
}
