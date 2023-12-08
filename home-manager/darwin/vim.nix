{ pkgs, ... }:

{
  programs.vim.packageConfigurable = pkgs.vim_configurable.override {
    guiSupport = false;
    darwinSupport = true;
  };
}
