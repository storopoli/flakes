{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    arkenfox = {
      enable = true;
      version = "118.0";
    };
    profiles.user = {
      bookmarks = [ ];
      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        vimium
      ];
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        arkenfox = {
          enable = true;
          "5000".enable = true;
          # disable saving passwords
          "5003"."signon.rememberSignons".value = false;

          "7000".enable = true;
          # enable WebRTC
          "7020"."media.peerconnection.enabled".value = true;
        };
      };
    };
  };
}
