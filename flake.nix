{
  description = "custompkgs";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }: {
    overlay =
      builtins.trace "Warning: This flake has been merged into github:Sciencentistguy/nixfiles"
      (final: pkgs: {
        gimp-unstable = pkgs.callPackage ./pkgs/gimp-unstable {};
        speedtest-exporter = pkgs.callPackage ./pkgs/speedtest-exporter {};
        run-one = pkgs.callPackage ./pkgs/run-one {};
        shark-radar = pkgs.callPackage ./pkgs/shark-radar {};
        ctre = pkgs.callPackage ./pkgs/ctre {};
        robin-hood-hashing = pkgs.callPackage ./pkgs/robin-hood-hashing {};
        beets-file-info = pkgs.callPackage ./pkgs/beets-file-info {};
        sherlock = pkgs.callPackage ./pkgs/sherlock {};
      });
  };
}
