{
  lib,
  buildGoModule,
  fetchFromGitHub,
  massdns,
  makeWrapper,
}:
buildGoModule rec {
  pname = "puredns";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "gprime31";
    repo = "puredns";
    tag = "v${version}";
    hash = "sha256-l7+lxiTaVc0hDMJh9/zNs2H/4kBoxwSpLVOakOdrNn8=";
  };

  vendorHash = "sha256-aiMlfR1CFjf6Y45giRY6TnHdpVfQeezJiLM4JCMhbdg=";

  buildInputs = [massdns];
  nativeBuildInputs = [makeWrapper];

  doCheck = false;

  ldflags = ["-s" "-w"];

  postInstall = ''
    wrapProgram $out/bin/puredns \
      --prefix PATH : ${lib.makeBinPath [massdns]}
  '';

  meta = with lib; {
    description = "Fast domain resolver and subdomain bruteforcing tool that can accurately filter out wildcard subdomains and DNS poisoned entries";
    homepage = "https://github.com/gprime31/puredns";
    license = licenses.gpl3Only;
  };
}
