{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonApplication rec {
  pname = "paramspider";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "devanshbatham";
    repo = "ParamSpider";
    tag = "v${version}";
    hash = "sha256-tfk4cgpX+nXPb7N2qO1o6++d9R0El1NJVvklE+yGrrk=";
  };

  propagatedBuildInputs = with python3Packages; [
    requests
    urllib3
    colorama
    rich
  ];

  doCheck = false;

  meta = with lib; {
    description = "Mining URLs from dark corners of Web Archives for bug hunting/fuzzing/further probing";
    homepage = "https://github.com/devanshbatham/ParamSpider";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
