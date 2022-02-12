{ naersk, }:
final: pkgs:
let
  custompkgs = pkgs.callPackage ./default.nix { inherit naersk; };
in
custompkgs
