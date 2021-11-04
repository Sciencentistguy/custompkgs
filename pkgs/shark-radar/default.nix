{ pkgs ? import <nixpkgs> { } }:

with pkgs;
with python3Packages;

stdenv.mkDerivation rec {
  name = "shark-radar";
  version = "0.0";
  src = fetchgit {
    url = "https://git.lavender.software/charlotte/shark-radar.git";
    rev = "da2d21ab3e287f535900f7494bdc33911e1d69a3";
    sha256 = "bh/+Fa9Li9miMyC7zRGdmTk2PbXD8QNhupHL3sMMl2c=";
  };

  nativeBuildInputs = [
    dos2unix
  ];

  prePatch = ''
    dos2unix list.py
  '';

  patches = [
    ./interpreter.patch
  ];

  postPatch = ''
    substituteInPlace list.py --replace "stores.json" "${placeholder "out"}/usr/share/shark-radar/stores.json"
  '';

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    install -Dm755 list.py ${placeholder "out"}/bin/shark-radar
    install -Dm644 stores.json ${placeholder "out"}/usr/share/shark-radar/stores.json
  '';

  propogatedBuildInputs = [
    colorama
    requests
  ];

}
