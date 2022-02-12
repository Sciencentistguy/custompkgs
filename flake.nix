{
  description = "custompkgs";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    naersk.url = github:nix-community/naersk;
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = { self, nixpkgs, naersk, flake-utils, ... }:
    {
      overlay = final: pkgs: {
        gimp = pkgs.callPackage ./pkgs/gimp-unstable { };
        starship = pkgs.callPackage ./pkgs/starship { naersk = naersk.lib."${pkgs.stdenv.system}"; };
        speedtest-exporter = pkgs.callPackage ./pkgs/speedtest-exporter { };
        run-one = pkgs.callPackage ./pkgs/run-one { };
        shark-radar = pkgs.callPackage ./pkgs/shark-radar { };
        ctre = pkgs.callPackage ./pkgs/ctre { };
        robin-hood-hashing = pkgs.callPackage ./pkgs/robin-hood-hashing { };
        beets-file-info = pkgs.callPackage ./pkgs/beets-file-info { };
        sherlock = pkgs.callPackage ./pkgs/sherlock { };
      };
    };
  # flake-utils.lib.eachDefaultSystem (system:
  # let pkgs = nixpkgs.legacyPackages.${system}; in
  # with pkgs; rec {
  # }
  # );

}
