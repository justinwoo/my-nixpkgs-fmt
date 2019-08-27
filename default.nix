{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in
pkgs.stdenv.mkDerivation rec {
  name = "nixpkgs-fmt";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/my-nixpkgs-fmt/releases/download/20190828/nixpkgs-fmt.tar.gz";
    sha256 = "0ivhnmq9giy1sjw4nw5h6q06rskra4nyza89vvk7gal8mi818vcb";
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
