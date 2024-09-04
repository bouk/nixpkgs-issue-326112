{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }: flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [
        (import rust-overlay)
      ];
      pkgs = (import nixpkgs) {
        inherit system overlays;
        config.allowUnfree = true;
      };
      toolchain = pkgs.rust-bin.nightly."2024-01-01".default;
    in
    {
      packages.test = pkgs.buildRustCrate
        {
          crateName = "test";
          version = "1.0.0";
          src = ./.;

          rustc = toolchain;
          cargo = toolchain;
        };
    });
}
