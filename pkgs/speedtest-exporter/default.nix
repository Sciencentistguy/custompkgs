{ buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "speedtest-exporter";
  version = "0.3.2";
  src = fetchFromGitHub {
    owner = "nlamirault";
    repo = "speedtest_exporter";
    rev = "7364db62b98ab2736405c7cde960698ab5b688bf";
    sha256 = "WIMDv63sHyZVw3Ct5LFXCIufj7sU2H81n+hT/NiPMeQ=";
  };

  goPackagePath = "github.com/nlamirault/speedtest_exporter";

  goDeps = ./deps.nix;
}
