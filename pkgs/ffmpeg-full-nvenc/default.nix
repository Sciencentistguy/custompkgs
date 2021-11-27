{ pkgs ? import <nixpkgs> { }
, stdenv ? pkgs.stdenv
}:

with pkgs;

let
  # This uses nixGL to use the system libcuda.so, because nix is apparently unable to do this itself
  # See: https://github.com/NixOS/nixpkgs/issues/77834
  nixGLPkgs = import
    (fetchTarball {
      name = "nixGL";
      url = "https://github.com/guibou/nixGL/archive/c4aa5aa15af5d75e2f614a70063a2d341e8e3461.tar.gz";
      sha256 = "09p7pvdlf4sh35d855lgjk6ciapagrhly9fy8bdiswbylnb3pw5d";
    })
    { inherit pkgs; };
  ffmpeg = ffmpeg-full.override {
    nonfreeLicensing = true;
    fdkaacExtlib = true;
  };
in
stdenv.mkDerivation {
  name = "ffmpeg-full-nvenc";
  version = "4.4.1";
  src = ./.;

  dontBuild = true;

  buildInputs = [
    ffmpeg
    nixGLPkgs.auto.nixGLDefault
  ];

  installPhase = ''
    install -Dm755 ffmpeg ${placeholder "out"}/bin/ffmpeg
  '';

}
