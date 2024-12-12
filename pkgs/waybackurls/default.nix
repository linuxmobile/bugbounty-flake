{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "waybackurls";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "tomnomnom";
    repo = "waybackurls";
    rev = "v${version}";
    sha256 = "sha256-aX6pCEp2809oYn1BUwdfKzJzMttnZItGXC1QL4yMztg=";
  };

  vendorHash = null;

  meta = with lib; {
    description = "Fetch known URLs from the Wayback Machine for *.domain";
    homepage = "https://github.com/tomnomnom/waybackurls";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
