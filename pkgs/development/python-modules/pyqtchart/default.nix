{ lib, python3Packages, pkgconfig, qmake, qtbase, qtsvg, qtcharts
, wrapQtAppsHook }:

let

  inherit (python3Packages) buildPythonPackage python pyqt5;
  inherit (pyqt5) sip;

in buildPythonPackage rec {
  pname = "PyQtChart";
  version = "5.15.0";
  format = "other";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0qb6fmfg9n9wpvraqrdzzqpwgqdqi1msrfqrs1cqiisrcyb1lsvr";
  };

  outputs = [ "out" "dev" ];

  nativeBuildInputs = [ pkgconfig qmake sip qtbase qtsvg qtcharts ];

  buildInputs = [ sip qtbase qtsvg qtcharts ];

  propagatedBuildInputs = [ pyqt5 ];

  postPatch = ''
    substituteInPlace configure.py \
      --replace \
      "target_config.py_module_dir" \
      "'$out/${python.sitePackages}'"
  '';

  configurePhase = ''
    runHook preConfigure
    mkdir -p "$out/share/sip/PyQt5"
    ${python.executable} configure.py -w \
      --destdir="$out/${python.sitePackages}/PyQt5" \
      --qtchart-sipdir=$out/share/sip/PyQt5 \
      --pyqt-sipdir="${pyqt5}/share/sip/PyQt5" \
      --apidir="$out/api/${python.libPrefix}" \
      --stubsdir="$out/${python.sitePackages}/PyQt5"
    runHook postConfigure
  '';

  postInstall = ''
    # Let's make it a namespace package
    cat << EOF > $out/${python.sitePackages}/PyQt5/__init__.py
    from pkgutil import extend_path
    __path__ = extend_path(__path__, __name__)
    EOF
  '';

  enableParallelBuilding = true;

  passthru = { inherit wrapQtAppsHook; };

  meta = with lib; {
    description = "Python bindings for Qt5";
    homepage = "http://www.riverbankcomputing.co.uk";
    license = licenses.gpl3;
    platforms = platforms.mesaPlatforms;
  };
}
