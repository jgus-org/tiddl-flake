# Upstream and distributed artifacts

| Artifact                                                                                  | Licence & Notifications                                                                                                                                                              |
| ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| This flake: `flake.nix`, `pin.nix`, `LICENSE.md`, `NOTICE.md`, `README.md`                | [MIT](LICENSE.md)                                                                                                                                                                    |
| `tiddl` 3.4.4, fetched from PyPI as `tiddl-3.4.4.tar.gz` by the hash `pin.nix` records    | [Apache-2.0](https://github.com/oskvr37/tiddl/blob/main/LICENSE) — the source distribution carries its own 11,357-byte copy at `tiddl-3.4.4/LICENSE`, which is the copy that travels |
| `python3` and the eight Python packages the recipe names, all from this flake's `nixpkgs` | Recorded by nixpkgs per package; see nixpkgs' own records                                                                                                                            |

Nothing else is conveyed. The Python dependency graph resolves inside nixpkgs — the source distribution is pure Python and builds against the interpreter's own package set — and every tool the build reaches comes from the same nixpkgs and is recorded there, package by package. Restating that set here would only go stale.
