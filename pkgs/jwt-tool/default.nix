{
  lib,
  python3,
  fetchFromGitHub,
}: let
  pythonEnv = python3.withPackages (ps:
    with ps; [
      termcolor
      pycryptodomex
      requests
      colorama
    ]);
in
  pythonEnv.pkgs.stdenv.mkDerivation rec {
    pname = "jwt_tool";
    version = "2.2.7";

    src = fetchFromGitHub {
      owner = "ticarpi";
      repo = "jwt_tool";
      tag = "v${version}";
      hash = "sha256-byLw1ppvRdppADufsxcRRxW0uyDT6Y0EDTCrw5hxK0Y=";
    };

    nativeBuildInputs = [pythonEnv];

    installPhase = ''
      mkdir -p $out/lib/jwt_tool
      cp jwt_tool.py $out/lib/jwt_tool/
      cp -r jwks-common.txt jwt-common.txt common-payloads.txt common-headers.txt $out/lib/jwt_tool/

      mkdir -p $out/bin
      cat > $out/bin/jwt_tool << EOF
      #!/bin/sh
      export JWT_TOOL_PATH="$out/lib/jwt_tool"
      exec ${pythonEnv}/bin/python $out/lib/jwt_tool/jwt_tool.py "\$@"
      EOF
      chmod +x $out/bin/jwt_tool
    '';

    meta = with lib; {
      description = "A toolkit for testing, tweaking and cracking JSON Web Tokens";
      homepage = "https://github.com/ticarpi/jwt_tool";
      license = licenses.gpl3Only;
      platforms = platforms.all;
    };
  }
