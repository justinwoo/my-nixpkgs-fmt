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
    rev = "44fdb18c25bc1de31fb23f49bc51d03bb70718f6";
    sha256 = "17c5wazag1csr9i0kh5qglv1v007q05bq71dx8cbdsvm6vs71k0l";
  }
) {}
```

## secret release process

`tar -cf nixpkgs-fmt.tar.gz nixpkgs-fmt`
