{ pkgs ? import <nixpkgs> { }
, stdenv
}:
with pkgs;
let
  rev = "78fda3012c68ec807f7e913548061a9b81fd2853";
in
rustPlatform.buildRustPackage rec {
  pname = "starship";
  version = "1.3.0-sciencentistguy";

  src = fetchFromGitHub {
    owner = "sciencentistguy";
    repo = pname;
    inherit rev;
    sha256 = "sha256-obZcwpn3zKBR4ND5Q3GWmOrfbOopr3pQQVRELr7o2xQ=";
  };

  cargoSha256 = "sha256-lkkhUlkzp3nDPyyydU33/JjOgnRXeUWwoMQ/sGW4lvQ=";

  # cargoLock = {
    # lockFile = builtins.fetchurl "https://raw.githubusercontent.com/Sciencentistguy/starship/${rev}/Cargo.lock";
  # };

  nativeBuildInputs = [ installShellFiles ] ++ lib.optionals stdenv.isLinux [ pkg-config ];

  buildInputs = lib.optionals stdenv.isLinux [ openssl ]
    ++ lib.optionals stdenv.isDarwin [ libiconv ];

  postInstall = ''
    for shell in bash fish zsh; do
      STARSHIP_CACHE=$TMPDIR $out/bin/starship completions $shell > starship.$shell
      installShellCompletion starship.$shell
    done
  '';

  preCheck = ''
    HOME=$TMPDIR
  '';

  # meta = with pkgs.lib; {
  # description = "A minimal, blazing fast, and extremely customizable prompt for any shell";
  # homepage = "https://starship.rs";
  # license = licenses.isc;
  # };
}
