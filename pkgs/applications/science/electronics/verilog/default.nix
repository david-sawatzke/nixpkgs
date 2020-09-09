{ stdenv, fetchFromGitHub, autoconf, gperf, flex, bison, readline, ncurses
, bzip2, zlib
}:

stdenv.mkDerivation rec {
  pname = "iverilog";
  version = "unstable-2020-09-09";

  src = fetchFromGitHub {
    owner  = "steveicarus";
    repo = pname;
    rev    = "d8556e4c86e1465b68bdc8d5ba2056ba95a42dfd";
    sha256 = "1ywmqiz9bzd03k8snhbvpcrjxw0sijmzwiva7163w51n8kzn6gxi";
  };

  enableParallelBuilding = true;

  prePatch = ''
    substituteInPlace configure.in \
      --replace "AC_CHECK_LIB(termcap, tputs)" "AC_CHECK_LIB(termcap, tputs)"
  '';

  preConfigure = ''
    chmod +x $PWD/autoconf.sh
    $PWD/autoconf.sh
  '';

  nativeBuildInputs = [ autoconf gperf flex bison ];

  buildInputs = [ readline ncurses bzip2 zlib ];

  meta = with stdenv.lib; {
    description = "Icarus Verilog compiler";
    repositories.git = "https://github.com/steveicarus/iverilog.git";
    homepage = "http://iverilog.icarus.com/";
    license = licenses.lgpl21;
    maintainers = with maintainers; [ winden ];
    platforms = platforms.all;
  };
}
