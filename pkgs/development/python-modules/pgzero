{ lib, buildPythonPackage, fetchFromGitHub, pythonPackages }:

buildPythonPackage rec {
  pname = "pgzero";
  version = "1.2.post5";

  src = fetchFromGitHub {
    owner = "lordmauve";
    repo = "pgzero";
    rev = version;
    sha256 = "0921b24izgnmkgn887296rpl6x4i0x694lnb97csyyidn5ihv8ws";
  };

  doCheck = false;

  postPatch= ''
    rm test/test_screen.py test/test_actor.py
  '';

  propagatedBuildInputs = with pythonPackages; [ pygame numpy ];

  meta = with lib; {
    description = "For creating games without boilerplate";
    homepage = "https://pygame-zero.readthedocs.io/en/stable/";
    license = licenses.lgpl3;
    maintainers = [ maintainers.das-g ];
    platforms = platforms.all;
  };
}
