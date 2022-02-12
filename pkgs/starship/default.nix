{ pkgs ? import <nixpkgs> { }
, stdenv
, naersk
}:

with pkgs; naersk.buildPackage rec {
  pname = "starship";
  version = "1.2.1-sciencentistguy";

  singleStep = true;

  src = fetchFromGitHub {
    owner = "sciencentistguy";
    repo = pname;
    rev = "6f1f5bd0b82ebc17285cf46f99130891dd10c727";
    sha256 = "sha256-he2MowiMny+BduXZ+FmHxxn+IM+rx6thkKXVg3Ni8vs=";
  };

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

  meta = with pkgs.lib; {
    description = "A minimal, blazing fast, and extremely customizable prompt for any shell";
    homepage = "https://starship.rs";
    license = licenses.isc;
  };
}
