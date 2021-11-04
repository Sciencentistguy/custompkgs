{ pkgs ? import <nixpkgs> { } }:

with pkgs; {
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays


  speedtest-exporter = callPackage ./speedtest-exporter { };
  gimp-299 = callPackage ./gimp-299 { };

}
