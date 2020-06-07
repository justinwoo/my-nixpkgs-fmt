{ pkgs ? import <nixpkgs> {} }:
let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
in
pkgs.stdenv.mkDerivation rec {
  name = "nixpkgs-fmt";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/my-nixpkgs-fmt/releases/download/2020-06-08/nixpkgs-fmt.tar.gz";
    sha256 = "163xin1n3gjxxs1v2lhcs8cgzmw6zplidplxpl3vs2p2rbx57474";
  };

  buildInputs = [ pkgs.glibc ];

  dontStrip = true;

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  unpackPhase = ''
    mkdir -p $out/bin
    tar xf $src -C $out/bin

    patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $out/bin/nixpkgs-fmt
  '';

  dontInstall = true;
}
