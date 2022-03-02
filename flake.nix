{
  description = "Rustdesk remote desktop flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      rec {
        packages = rec {
          libsciter = pkgs.callPackage ./libsciter.nix { };
          libyuv = pkgs.callPackage ./libyuv.nix { };
          rustdesk = pkgs.callPackage ./rustdesk.nix { inherit libsciter libyuv; };
        };

        defaultPackage = packages.rustdesk;
      }
    );
}
