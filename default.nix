{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in pkgs.stdenv.mkDerivation rec {
  name = "nixpkgs-fmt";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/my-nixpkgs-fmt/releases/download/20190828/nixpkgs-fmt.tar.gz";
    sha256 = "0gjaz22d2pisy4fk47d1m6gk6wgx293szm8mdhdy89050wwqpsz0";
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
