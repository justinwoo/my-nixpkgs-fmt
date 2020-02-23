{ pkgs ? import <nixpkgs> {} }:
let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
in
pkgs.stdenv.mkDerivation rec {
  name = "nixpkgs-fmt";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/my-nixpkgs-fmt/releases/download/2020-02-23/nixpkgs-fmt.tar.gz";
    sha256 = "0lz2rzmkvmjk8qim1m6ckr9mchi2p7kcbpwvvcx61zn8lym3xpj8";
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
