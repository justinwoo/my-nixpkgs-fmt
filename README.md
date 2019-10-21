# my-nixpkgs-fmt

my non-portable nixpkgs-fmt build. for use by me.

see <https://github.com/nix-community/nixpkgs-fmt> instead.

## install

```nix
{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "my-nixpkgs-fmt";
    rev = "4496a67817e3dc2f40c60db971a1d503b353415c";
    sha256 = "1z9k1jlbqlfb2wgqlvpqvlrxwpz3j9syinx6f8705z34q1yjnxnb";
  }
) {}
```

## secret release process

`tar -cf nixpkgs-fmt.tar.gz nixpkgs-fmt`
