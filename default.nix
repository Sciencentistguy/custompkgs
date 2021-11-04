{ pkgs ? import <nixpkgs> { } }:

with pkgs; {
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  gimp = callPackage ./pkgs/gimp-unstable { };
  starship = callPackage ./pkgs/starship-fork { };
  speedtest-exporter = callPackage ./pkgs/speedtest-exporter { };
}

