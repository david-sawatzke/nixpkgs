{ stdenv, lib, fetchurl, pkgs, qt5, python3Packages }:

stdenv.mkDerivation rec {
  pname = "pyqtchart";
  version = "5.12";

  src = fetchurl {
    url = "https://www.riverbankcomputing.com/static/Downloads/PyQtChart/${version}/PyQtChart_gpl-5.12.tar.gz";
    sha256 = "1my07cksnsxbcc7h7i0429xj712jrs3sqwdmifjv3pw1kyhcdsmc";
  };

  nativeBuildInputs = [
    qt5.qmake
    python3Packages.pyqt5
  ];

  buildInputs = with pkgs; [
    python
  ];

  configurePhase = ''
    python ./configure.py
  '';
}
