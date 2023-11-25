{ config, pkgs, lib, ... }:

{
  programs = {
    broot = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        modal = true;
        verbs = [
          {
            invocation = "edit";
            shortcut = "e";
            execution = "$EDITOR {file}";
          }
        ];
      };
    };
  };
}
