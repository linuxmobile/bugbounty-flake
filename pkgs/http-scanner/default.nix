{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "http-scanner";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "aymaneallaoui";
    repo = "kafka-http-scanner";
    tag = "v${version}";
    hash = "sha256-+8UpdNRuu0nTYiBBS+yiVwDEtC/KpEeyPCEeJvsjxfs=";
  };

  vendorHash = "sha256-Nvp9Qd1lz6/4fTgvqpInk+QhKYr/Fcunw53WERBpT8Q=";

  # proxyVendor = true;

  ldflags = [
    "-s"
    "-w"
    "-X github.com/aymaneallaoui/kafka-http-scanner/pkg/utils.Version=${version}"
  ];

  postInstall = ''
    mkdir -p $out/share/${pname}/configs
    cp -r configs/* $out/share/${pname}/configs/

    mkdir -p $out/bin
    mv $out/bin/kafka-http-scanner $out/bin/httpscan
  '';

  meta = with lib; {
    description = "An advanced HTTP security vulnerability scanner that detects web application vulnerabilities";
    homepage = "https://github.com/aymaneallaoui/kafka-http-scanner";
    license = licenses.mit;
    mainProgram = "httpscan";
    platforms = platforms.unix;
  };
}
