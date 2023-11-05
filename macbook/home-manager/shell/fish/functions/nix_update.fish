# https://nixos.org/manual/nix/stable/installation/upgrading
function nix_update
  sudo -i sh -c "nix-channel --update && nix-env --install --attr nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist"
  nix-collect-garbage -d      
end
