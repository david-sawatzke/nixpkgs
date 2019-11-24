{ lib, buildPythonPackage, fetchFromGitHub, pythonPackages }:

buildPythonPackage rec {
  pname = "nudatus";
  version = "0.0.4";

  src = fetchFromGitHub {
    owner = "ZanderBrown";
    repo = pname;
    rev = version;
    sha256 = "0z6m5xi62rg2nz6qi8ys0y48rxgcl0mmiz7h7w7cli8f7r03j4rb";
  };

  checkInputs = with pythonPackages; [ pytest ];
  checkPhase = ''
    py.test
  '';

  meta = with lib; {
    description = "A tool to remove comments from Python scripts";
    homepage = "https://github.com/zanderbrown/nudatus";
    license = licenses.mit;
    maintainers = [ maintainers.das-g ];
    platforms = platforms.all;
  };
}
