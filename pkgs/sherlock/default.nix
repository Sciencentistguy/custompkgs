{
  pkgs ? import <nixpkgs> {},
  python3Packages,
  stdenv,
  fetchFromGitHub,
  python3,
}:
# Needs to be used in a shell, not installed globally
let
  torrequests = python3Packages.buildPythonPackage rec {
    pname = "torrequest";
    version = "0.1.0";
    src = builtins.fetchurl {
      url = "https://files.pythonhosted.org/packages/a3/d2/00538e47a2c80979231313c346a0abc3927c7b230d69eb923bb5b221ec62/torrequest-0.1.0.tar.gz";
      sha256 = "10mf9p6r4wwk9m50jh5bpmvsnymkmn3wfqs30dx8vagx7zmd8i9p";
    };
    format = "setuptools";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [
      python3Packages.pysocks
      python3Packages.requests
      python3Packages.stem
    ];
  };
in
  stdenv.mkDerivation rec {
    pname = "sherlock";
    version = "git";

    src = fetchFromGitHub {
      repo = "sherlock";
      owner = "sherlock-project";
      rev = "c7262e11ba73f72880b1866e4c3d2a5acdc610b0";
      sha256 = "sha256-5eo6U+IcD66pNhcR2Nqc4OsG0AbU4TsAz1bn58de9mg=";
    };

    propagatedBuildInputs = [
      pkgs.python3
      pkgs.python3Packages.requests
      pkgs.python3Packages.requests-futures
      pkgs.python3Packages.colorama
      torrequests
    ];

    postPatch = ''
      echo "#!/bin/sh" >> wrapper.sh
      echo "exec ${pkgs.python3}/bin/python3 ${placeholder "out"}/share/${pname}/${pname}.py \"\$@\"" >> wrapper.sh
    '';

    installPhase = ''
      install -Dm755 wrapper.sh $out/bin/${pname}
      install -d $out/share/
      cp -af ${pname} $out/share/
    '';
  }
