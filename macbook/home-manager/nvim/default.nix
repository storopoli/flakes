{ config, pkgs, lib, ... }:

{
  home = {
    packages = with pkgs; [
      # Neovim deps
      neovim
      fzf
      ripgrep
      fd
      nodejs

      # LSPs
      gopls
      ltex-ls
      lua-language-server
      marksman
      nil
      nodePackages_latest.bash-language-server
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vscode-langservers-extracted
      ruff-lsp
      rust-analyzer
      taplo
      texlab
      typst-lsp
      yaml-language-server

      # tree-sitter
      tree-sitter

      # debugger
      lldb # provides lldb-vscode

      # linters
      codespell
      luajitPackages.luacheck
      markdownlint-cli2
      nodePackages_latest.eslint
      ruff
      shellcheck

      # formatter
      black
      dprint
      isort
      nixpkgs-fmt
      prettierd
      shellharden
      shfmt
      stylua
      typstfmt
    ];
    file.".config/nvim".source = pkgs.fetchFromGitHub {
      owner = "storopoli";
      repo = "nvim";
      rev = "v1.5";
      hash = "sha256-TIGGiUaF2jwUgLr28C5psm36NJScZcjAQB60iiVTvoY=";
    };
  };
}
