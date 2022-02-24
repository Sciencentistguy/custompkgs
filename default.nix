{ pkgs ? import <nixpkgs> { }
, stdenv ? pkgs.stdenv
, callPackage ? pkgs.callPackage
}:
rec {
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  gimp = callPackage ./pkgs/gimp-unstable { };
  starship = callPackage ./pkgs/starship { };
  speedtest-exporter = callPackage ./pkgs/speedtest-exporter { };
  run-one = callPackage ./pkgs/run-one { };
  shark-radar = callPackage ./pkgs/shark-radar { };
  ctre = callPackage ./pkgs/ctre { };
  robin-hood-hashing = callPackage ./pkgs/robin-hood-hashing { };
  beets-file-info = callPackage ./pkgs/beets-file-info { };
  sherlock = callPackage ./pkgs/sherlock { };
}
