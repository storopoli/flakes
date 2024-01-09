{ pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;

      package = pkgs.vscodium;

      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "language-julia";
          publisher = "julialang";
          version = "1.66.1";
          sha256 = "1rk56i1yv8jwhr3ckphpxxkhw6s46xfxfqd2mwai7i2jq59zsla2";
        }
      ];

      userSettings = {
        # General configs
        "telemetry.telemetryLevel" = "off"; # most important
        "update.mode" = "none";
        "window.restoreWindows" = "none";
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "Default Dark Modern";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.inlineSuggest.enabled" = true;
        "terminal.integrated.sendKeybindingsToShell" = true;
        "terminal.integrated.shellIntegration.enabled" = true;
        "terminal.integrated.gpuAcceleration" = "canvas";

        # Git settings
        "git.autofetch" = false;
        "git.autorefresh" = true;
        "git.confirmSync" = false;
        "git.enableCommitSigning" = true;
        "github.gitProtocol" = "ssh";

        # Julia
        "julia.execution.codeInREPL" = true;
        "julia.enableCrashReporter" = false;
        "julia.enableTelemetry" = false;
        "julia.useRevise" = true;
        "julia.symbolCacheDownload" = true;
        "julia.NumThreads" = "auto";
        "julia.runtimeCompletions" = true;

        # "julia.persistentSession.enabled"= true;
        "terminal.integrated.commandsToSkipShell" = [
          "language-julia.interrupt"
        ];

        # Vim
        "vim.highlightedyank.enable" = true;
      };
    };
  };
}
