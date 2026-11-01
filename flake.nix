{
  description = "tiddl: CLI Tidal downloader (oskvr37/tiddl), the download backend Tidarr shells out to.";

  inputs = {
    flake-lib = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:jgus-org/flake-lib/v1";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      flake-lib,
      nixpkgs,
    }:
    flake-lib.lib.mkPythonFlake {
      inherit nixpkgs self;
      payload.packages =
        {
          buildApplication,
          pkgs,
          python,
          ...
        }:
        {
          tiddl = buildApplication {
            build-system = with python; [
              setuptools
              wheel
            ];
            dependencies = with python; [
              aiofiles
              aiohttp
              m3u8
              mutagen
              pydantic
              requests
              requests-cache
              typer
            ];
            # Upstream pins exact lower bounds we may exceed in nixpkgs; the CLI works fine across them.
            dontCheckRuntimeDeps = true;
            meta = {
              description = "tiddl: CLI Tidal downloader (oskvr37/tiddl), the download backend Tidarr shells out to.";
              homepage = "https://github.com/oskvr37/tiddl";
              license = pkgs.lib.licenses.asl20;
              mainProgram = "tiddl";
            };
            pname = "tiddl";
            pyproject = true;
          };
        };
      updateBranches.minimumTrackingVersion = "3.4.3";
      upstream = {
        format = "sdist";
        pin = import ./pin.nix;
        pname = "tiddl";
        type = "pypi";
      };
    };
}
