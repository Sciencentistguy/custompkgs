{ starship, fetchFromGitHub, lib }:
let
  rev = "07870a45877ee3f25471a1a0f100d1312a4f6e3c";
in
starship.overrideAttrs (old: rec {
  version = "1.3.0-sciencentistguy";
  src = fetchFromGitHub {
    owner = "sciencentistguy";
    repo = "starship";
    inherit rev;
    sha256 = "sha256-obZcwpn3zKBR4ND5Q3GWmOrfbOopr3pQQVRELr7o2xQ=";
  };

  cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
    name = "${old.pname}-${version}-vendor.tar.gz";
    inherit src;
    outputHash = "sha256-lkkhUlkzp3nDPyyydU33/JjOgnRXeUWwoMQ/sGW4lvQ=";
  });
})
