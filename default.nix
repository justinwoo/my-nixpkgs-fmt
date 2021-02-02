{ pkgs ? import <nixpkgs> { } }:
let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
in
pkgs.stdenv.mkDerivation rec {
  name = "nixpkgs-fmt";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/my-nixpkgs-fmt/releases/download/2021-02-03/nixpkgs-fmt.tar.gz";
    sha256 = "0b912sbxgxyg314ab941vky5dw51zi24w4vryjr74sfrkl1k5ma3";
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
