{ pkgs, lib, ... }:

let
  nvim-spell-en-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl";
    sha256 = "0w1h9lw2c52is553r8yh5qzyc9dbbraa57w9q0r9v8xn974vvjpy";
  };
  nvim-spell-en-utf8-suggestions = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.sug";
    sha256 = "1v1jr4rsjaxaq8bmvi92c93p4b14x2y1z95zl7bjybaqcmhmwvjv";
  };
  nvim-spell-pt-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl";
    sha256 = "0fxnd9fvvxawmwas9yh47rakk65k7jjav1ikzcy7h6wmnq0c2pry";
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      friendly-snippets
      nvim-autopairs
      nvim-surround
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-file-browser-nvim
      nvim-web-devicons
      catppuccin-nvim
      lualine-nvim
      comment-nvim
      gitsigns-nvim
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        tree-sitter-bash
        tree-sitter-bibtex
        tree-sitter-c
        tree-sitter-comment
        tree-sitter-cpp
        tree-sitter-css
        tree-sitter-fish
        tree-sitter-html
        tree-sitter-http
        tree-sitter-json
        tree-sitter-julia
        tree-sitter-latex
        tree-sitter-llvm
        tree-sitter-lua
        tree-sitter-make
        tree-sitter-markdown
        tree-sitter-markdown-inline
        tree-sitter-nix
        tree-sitter-python
        tree-sitter-query
        tree-sitter-regex
        tree-sitter-rust
        tree-sitter-sql
        tree-sitter-toml
        tree-sitter-typst
        tree-sitter-vim
        tree-sitter-yaml
      ]))
      nvim-treesitter-textobjects
    ];
    extraConfig =
      let
        luaRequire = module:
          builtins.readFile (builtins.toString
            ./config
          + "/${module}.lua");
        luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
          "init"
          "disable_plugins"
          "keymaps"
          "highlight_yank"
          "restore_cursor"
          "theme"
          "nvim-cmp"
          "nvim-lspconfig"
          "telescope"
          "treesitter"
          "treesitter-textobjects"
          "lualine"
          "comment"
          "gitsigns"
          "typst"
        ]);
      in
      ''
        lua <<
        ${luaConfig}

      '';
  };

  home.packages = with pkgs; [
    # utils
    fzf
    ripgrep
    fd

    # LSPs
    marksman
    rnix-lsp
    nodePackages_latest.bash-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.pyright
    ruff
    ruff-lsp
    nodePackages_latest.vim-language-server
    rust-analyzer
    taplo
    texlab
    typst-lsp
    yaml-language-server
    lua-language-server
  ];

  xdg.configFile = {
    "nvim/spell/en.utf-8.spl".source = nvim-spell-en-utf8-dictionary;
    "nvim/spell/en.utf-8.sug".source = nvim-spell-en-utf8-suggestions;
    "nvim/spell/pt.utf-8.spl".source = nvim-spell-pt-utf8-dictionary;
  };
}
