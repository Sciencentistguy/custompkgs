{ pkgs ? import <nixpkgs> { } }:
with pkgs; stdenv.mkDerivation rec {
  pname = "robin-hood-hashing";
  version = "3.11.3";
  src = fetchFromGitHub {
    owner = "martinus";
    repo = "robin-hood-hashing";
    rev = version;
    sha256 = "9IamneqbZwQA63U2GyGTVWIHvwTtT+/oqQgaOCWno74=";
  };

  dontBuild = true;

  installPhase = ''
    install -Dm644 src/include/robin_hood.h ${placeholder "out"}/include/robin_hood.h
  '';

}
