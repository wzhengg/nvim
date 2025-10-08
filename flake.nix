{
  description = "Neovim Development Environment";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            inputs.neovim-nightly-overlay.packages.${pkgs.system}.default

            pkgs.lua
            pkgs.lua-language-server

            # fzf-lua
            pkgs.bat
            pkgs.fd
            pkgs.fzf
            pkgs.ripgrep

            # gitsigns
            pkgs.git

            # nvim-treesitter
            pkgs.curl
            pkgs.gcc
            pkgs.gnutar
            pkgs.nodejs_24
            pkgs.tree-sitter
          ];
        };
      }
    );
}
