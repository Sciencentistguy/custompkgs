{ pkgs
, stdenv
, rustPlatform
}:

with pkgs; rustPlatform.buildRustPackage rec {
  pname = "starship";
  version = "0.58.0-sciencentistguy";

  src = fetchFromGitHub {
    owner = "sciencentistguy";
    repo = pname;
    rev = "35f1e442e6691415df6e5c0ec4c86781f491a220";
    sha256 = "sha256-s84fIpCyTF7FrJZGATjIJHt/+aknlhlz1V9s+c4f+Ig=";
  };

  nativeBuildInputs = [ installShellFiles ] ++ lib.optionals stdenv.isLinux [ pkg-config ];

  buildInputs = lib.optionals stdenv.isLinux [ openssl ]
    ++ lib.optionals stdenv.isDarwin [ libiconv Security ];

  postInstall = ''
    for shell in bash fish zsh; do
      STARSHIP_CACHE=$TMPDIR $out/bin/starship completions $shell > starship.$shell
      installShellCompletion starship.$shell
    done
  '';

  cargoSha256 = "sha256-dCR9kSQsrZzK2um0yFJH1D2Fgj6v1nQpdwZq5ECdQL0=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  meta = with pkgs.lib; {
    description = "A minimal, blazing fast, and extremely customizable prompt for any shell";
    homepage = "https://starship.rs";
    license = licenses.isc;
    maintainers = with maintainers; [ bbigras davidtwco Br1ght0ne Frostman marsam ];
  };
}
