# tiddl-flake

A Nix flake that provides [tiddl](https://github.com/oskvr37/tiddl), a command-line downloader for Tidal, built from the project's PyPI source distribution.

## Outputs

- `packages.<system>.tiddl` — the tiddl package. `bin/tiddl` is the CLI and `meta.mainProgram` is `tiddl`.
- `packages.<system>.default` — the same derivation.
- `packages.<system>.update-version`, `packages.<system>.update-branches` — maintenance outputs that move the pin. Neither is needed to consume the flake.
- `checks.<system>.formatting`, `formatter` — this repository's own files.

There are no overlays, `nixosModules`, devShells or apps: nothing here installs a service.

## Consuming

```nix
# flake inputs
inputs.tiddl = {
  url = "github:jgus-org/tiddl-flake";
  inputs.nixpkgs.follows = "nixpkgs";
};

# then, for a system or user package set
inputs.tiddl.packages.${system}.tiddl
```

Following `nixpkgs` is optional but recommended: the CPython and every Python dependency come from that nixpkgs, so sharing it keeps them in step with the rest of a system. tiddl declares `requires-python >= 3.13`, so a consumer that follows a nixpkgs whose default `python3` is older is on its own to reconcile.

## Build hosts

`aarch64-darwin`, `aarch64-linux` and `x86_64-linux`, which are flake-lib's default build hosts. tiddl itself is pure Python; every compiled extension in its closure is one of nixpkgs' own packages.

## What you get

**The version upstream releases, unpatched.** The pin tracks PyPI and the recipe applies no patches.

**Dependency floors not enforced.** Upstream declares lower bounds on its eight dependencies; nixpkgs resolves them however its own channels choose, and the CLI works across that range, so the build skips the runtime-dependency check that would otherwise compare the two. A package set older than what upstream released against fails in use rather than at build time.

**State outside the package.** tiddl keeps its config and its Tidal auth token in `~/.tiddl`, or in `$TIDDL_PATH` when that is set, and creates that directory when the CLI starts. Downloads default to `~/Music/tiddl`. Nothing is written inside the package output, so a consumer that runs tiddl as another user or in a container supplies a writable home directory or an explicit `TIDDL_PATH`, and its own credentials.

See [LICENSE.md](LICENSE.md) for licensing and copyright, and [NOTICE.md](NOTICE.md) for the terms of upstream and distributed artifacts.
