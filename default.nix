{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  callPackage ? pkgs.callPackage,
}:
builtins.trace "Warning: This flake has been merged into github:Sciencentistguy/nixfiles" rec {
  lib = import ./lib {inherit pkgs;}; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  gimp-unstable = callPackage ./pkgs/gimp-unstable {};
  speedtest-exporter = callPackage ./pkgs/speedtest-exporter {};
  run-one = callPackage ./pkgs/run-one {};
  shark-radar = callPackage ./pkgs/shark-radar {};
  ctre = callPackage ./pkgs/ctre {};
  robin-hood-hashing = callPackage ./pkgs/robin-hood-hashing {};
  beets-file-info = callPackage ./pkgs/beets-file-info {};
  sherlock = callPackage ./pkgs/sherlock {};
}
