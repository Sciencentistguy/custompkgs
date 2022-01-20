{ pkgs ? import <nixpkgs> { }
, stdenv ? pkgs.stdenv
, rustPlatform ? pkgs.rustPlatform
, nearsk ? pkgs.callPackage
    (fetchTarball {
      url = "https://github.com/nix-community/naersk/archive/master.tar.gz";
    })
    { }
}:

with pkgs; nearsk.buildPackage rec {
  pname = "starship";
  version = "1.1.1-sciencentistguy";

  singleStep = true;

  src = fetchFromGitHub {
    owner = "sciencentistguy";
    repo = pname;
    rev = "80db1713bdfbee3eb63c4a0c2ed2188ac846a664";
    sha256 = "sha256-qFbbnjdA56LYoWFWyjxHkydqLmRHo64S7oOgMcNiNOs";
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
