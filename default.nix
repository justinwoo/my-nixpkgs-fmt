{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in
pkgs.stdenv.mkDerivation rec {
  name = "nixpkgs-fmt";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/my-nixpkgs-fmt/releases/download/20190923/nixpkgs-fmt.tar.gz";
    sha256 = "1p3jwj0126n00vpk6jvdbyz2kkggl1q63crn1a60a9wyw64g09l3";
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
