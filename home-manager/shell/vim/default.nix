{ pkgs, ... }:

let
  vim-spell-en-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl";
    sha256 = "0w1h9lw2c52is553r8yh5qzyc9dbbraa57w9q0r9v8xn974vvjpy";
  };
  vim-spell-en-utf8-suggestions = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.sug";
    sha256 = "1v1jr4rsjaxaq8bmvi92c93p4b14x2y1z95zl7bjybaqcmhmwvjv";
  };
  vim-spell-pt-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl";
    sha256 = "0fxnd9fvvxawmwas9yh47rakk65k7jjav1ikzcy7h6wmnq0c2pry";
  };
in
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-lsp
      vim-lsp-settings
      asyncomplete-vim
      asyncomplete-lsp-vim
      vim-vsnip
      vim-vsnip-integ
      friendly-snippets
      fzf-vim
      catppuccin-vim
      copilot-vim
    ];
    settings = {
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      hidden = true;
      ignorecase = true;
      smartcase = true;
    };
    extraConfig = builtins.readFile ./vimrc;
  };

  home.packages = with pkgs; [
    # utils
    fzf
    ripgrep

    # LSPs
    marksman
    nil
    nodePackages_latest.bash-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.pyright
    nodePackages_latest.vim-language-server
    ruff-lsp
    rust-analyzer
    taplo
    typst-lsp
    yaml-language-server
  ];

  home.file = {
    ".vim/spell/en.utf-8.spl".source = vim-spell-en-utf8-dictionary;
    ".vim/spell/en.utf-8.sug".source = vim-spell-en-utf8-suggestions;
    ".vim/spell/pt.utf-8.spl".source = vim-spell-pt-utf8-dictionary;
    ".vim/.undo/.placeholder".text = '''';
    ".vim/.backup/.placeholder".text = '''';
    ".vim/.swp/.placeholder".text = '''';
  };
}
