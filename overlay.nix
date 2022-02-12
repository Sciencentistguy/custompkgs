{ nearsk, }:
final: pkgs:
let
  custompkgs = pkgs.callPackage ./default.nix { inherit nearsk; };
in
custompkgs
