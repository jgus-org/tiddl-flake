{
  description = "tiddl: CLI Tidal downloader (oskvr37/tiddl), the download backend Tidarr shells out to.";

  inputs = {
    # Unfollowed on purpose: flake-lib resolves the org formatter from its own nixpkgs pin.
    flake-lib.url = "github:jgus-org/flake-lib/v1";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      flake-lib,
      nixpkgs,
    }:
    flake-lib.lib.mkPythonFlake {
      inherit
        nixpkgs
        self
        ;
      package = {
        attr = "tiddl";
        buildSystem =
          ps: with ps; [
            setuptools
            wheel
          ];
        dependencies =
          ps: with ps; [
            aiofiles
            aiohttp
            m3u8
            mutagen
            pydantic
            requests
            requests-cache
            typer
          ];
        description = "tiddl: CLI Tidal downloader (oskvr37/tiddl), the download backend Tidarr shells out to.";
        # Upstream pins exact lower bounds we may exceed in nixpkgs; the CLI works fine across them.
        extra.dontCheckRuntimeDeps = true;
        kind = "pythonApplication";
        meta = {
          homepage = "https://github.com/oskvr37/tiddl";
          license = nixpkgs.lib.licenses.asl20;
          mainProgram = "tiddl";
        };
      };
      pin = import ./pin.nix;
      source = {
        format = "sdist";
        pname = "tiddl";
        type = "pypi";
      };
      updateBranches.minimumTrackingVersion = "3.4.3";
    };
}
