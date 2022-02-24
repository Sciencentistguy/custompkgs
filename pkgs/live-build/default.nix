{ pkgs ? import <nixpkgs> { }
, stdenv ? pkgs.stdenv
, syslinux ? pkgs.syslinux
, fetchFromGitLab ? pkgs.fetchFromGitLab
}:
stdenv.mkDerivation rec {

  pname = "live-build";
  version = "1-20210902";

  src = fetchFromGitLab {
    domain = "salsa.debian.org";
    owner = "live-team";
    repo = "live-build";
    rev = "debian/1%20210902";
    sha256 = "uQd+XgD3CcwoiQIqr5PiZ0i/ZRV69G/qugRxfP48984=";
  };

  makeFlags = [
    "prefix=${placeholder "out"}"
    "DESTDIR=${placeholder "out"}"
  ];

  propogatedBuildInputs = [
    syslinux
  ];

  postPatch = '' 
    for file in $(grep -lirE "/usr" */); do
      echo $file
      substituteInPlace $file --replace "/usr" $out
    done
    for l in $(find -type l ! -exec test -e {} \; -print | sed "/^$/d"); do
      DEST=$(readlink $l)
      NEWDEST=$(echo $DEST | sed -e "s,/usr,${placeholder "out"},")
      printf "changing %s to %s\n" $DEST $NEWDEST
      rm $l
      ln -s $NEWDEST $l
    done
  '';

  postInstall = ''
    cd ${placeholder "out"}
    mv usr/* .
  '';

  # TODO: patch scripts somehow so they, like, work

}
