{ pkgs ? import <nixpkgs> { } }:

with pkgs; stdenv.mkDerivation rec {
  pname = "ctre";
  version = "3.4.1";

  src = fetchFromGitHub {
    owner = "hanickadot";
    repo = "compile-time-regular-expressions";
    rev = "v${version}";
    sha256 = "NoD5RHezrKiYO5AMYfxdciu+Q6vpqhwdGv/DLooFPFw=";
  };

  dontBuild = true;

  installPhase = ''
    for i in $(find ./include -type f); do
      install -Dm644 $i ${placeholder "out"}/$i
    done
  '';
}
