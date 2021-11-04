{ pkgs ? import <nixpkgs> { } }:
with pkgs;
pkgs.stdenv.mkDerivation {
  pname = "run-one";
  version = "1.17";
  src = fetchTarball "https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/run-one/1.17-0ubuntu1/run-one_1.17.orig.tar.gz";

  installPhase = ''
    install -Dm755 keep-one-running ${placeholder "out"}/bin/keep-one-running
    install -Dm755 run-one ${placeholder "out"}/bin/run-one
    install -Dm755 run-one.1 ${placeholder "out"}/usr/share/man/man1/run-one.1
    install -Dm755 run-one-constantly ${placeholder "out"}/bin/run-one-constantly
    install -Dm755 run-one-until-failure ${placeholder "out"}/bin/run-one-until-failure
    install -Dm755 run-one-until-success ${placeholder "out"}/bin/run-one-until-success
    install -Dm755 run-this-one ${placeholder "out"}/bin/run-this-one
  '';
}
