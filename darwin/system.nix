{ ... }:

{
  services = {
    nix-daemon.enable = true; # Auto-Upgrade Daemon
  };

  nix.gc.interval.Day = 7;

  system = {
    # Global macOS System Settings
    defaults = {
      # Dark Mode
      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      CustomUserPreferences = {
        NSGlobalDomain = {
          # Save to disk (not to iCloud) by default
          NSDocumentSaveNewDocumentsToCloud = false;
          # Expand save panel by default
          NSNavPanelExpandedStateForSaveMode = false;
          NSNavPanelExpandedStateForSaveMode2 = false;
          # Expand print panel by default
          PMPrintingExpandedStateForPrint = false;
          PMPrintingExpandedStateForPrint2 = false;
          # Disable automatic capitalization as it’s annoying when typing code
          NSAutomaticCapitalizationEnabled = false;
          # Disable smart dashes as they’re annoying when typing code
          NSAutomaticDashSubstitutionEnabled = false;
          # Disable automatic period substitution as it’s annoying when typing code
          NSAutomaticPeriodSubstitutionEnabled = false;
          # Disable smart quotes as they’re annoying when typing code
          NSAutomaticQuoteSubstitutionEnabled = false;
          # Disable auto-correct
          NSAutomaticSpellingCorrectionEnabled = false;
          # Disable press-and-hold for keys in favor of key repeat
          ApplePressAndHoldEnabled = false;
          # Set a blazingly fast keyboard repeat rate
          KeyRepeat = 2;
          InitialKeyRepeat = 10;
          # Enable subpixel font rendering on non-Apple LCDs
          # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
          AppleFontSmoothing = 2;
          # Finder: show all filename extensions
          AppleShowAllExtensions = true;
        };
        LaunchServices = {
          # Whether to enable quarantine for downloaded applications
          LSQuarantine = false;
        };
        dock = {
          # Automatically hide and show the Dock
          autohide = true;
          # Move Dock to the right
          orientation = "right";
          # Make Dock icons of hidden applications translucent
          showhidden = true;
          # Don’t show recent applications in Dock
          show-recents = false;
          tilesize = 40;
          # Don't animate opening applications from the Dock
          launchanim = false;
          # Speed up Mission Control animations
          expose-animation-duration = 0.1;
          # Don't show Dashboard as a Space
          dashboard-in-overlay = true;
          # Don’t automatically rearrange Spaces based on most recent use
          mru-spaces = false;
          # Remove the auto-hiding Dock delay
          autohide-delay = 0;
          # Remove the auto-hiding Dock delay
          autohide-time-modifier = 0;
        };
        finder = {
          # Whether to allow quitting of the Finder
          QuitMenuItem = false;
          # Show stuff in my Desktop
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
          # Display full POSIX path as Finder window title
          _FXShowPosixPathInTitle = true;
          # Disable the warning when changing a file extension
          FXEnableExtensionChangeWarning = false;
          # Disable the warning before emptying the Trash
          WarnOnEmptyTrash = false;
        };
        trackpad = {
          Clicking = true;
          TrackpadRightClick = true;
        };
        "com.apple.systempreferences" = {
          # Disable Resume system-wide
          NSQuitAlwaysKeepsWindows = false;
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.AdLib" = {
          # Don't fucking track me...
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.BluetoothAudioAgent" = {
          # Increase sound quality for Bluetooth headphones/headsets
          "Apple Bitpool Min (editable)" = -40;
        };
        "com.apple.dashboard" = {
          # Disable Dashboard
          mcx-disabled = true;
        };
        "com.apple.DiskUtility" = {
          # Enable the debug menu in Disk Utility
          DUDebugMenuEnabled = true;
          advanced-image-options = true;
        };
        "com.apple.TextEdit" = {
          # Use plain text mode for new TextEdit documents
          RichText = 0;
          # Open and save files as UTF-8 in TextEdit
          PlainTextEncoding = 4;
          PlainTextEncodingForWrite = 4;
        };
      };
      # Firewall
      alf = {
        # Enables Firewall
        globalstate = 1;
        # Enable logging of requests
        loggingenabled = 1;
        # Drops incoming requests via ICMP such as ping requests
        stealthenabled = 1;
      };
    };
    activationScripts.postUserActivation.text = ''
      # Automatically quit printer app once the print jobs complete
      defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

      # Disable Notification Center and remove the menu bar icon
      launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

      # Enable HiDPI display modes (requires restart)
      sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

      # Enable snap-to-grid for icons on the desktop and in other icon views
      /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
      /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
      /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

      # Expand the following File Info panes:
      # "General", "Open with", and "Sharing & Permissions"
      defaults write com.apple.finder FXInfoPanesExpanded -dict \
        	    General -bool true \
        	    OpenWith -bool true \
        	    Privileges -bool true

      # Only use UTF-8 in Terminal.app
      defaults write com.apple.terminal StringEncodings -array 4

      # Disable the annoying line marks
      defaults write com.apple.Terminal ShowLineMarks -int 0

      # MacOS Ventura from Unredacted Magazine #5
      # disables all leftover Siri services
      defaults write com.apple.assistant.support 'Assistant Enabled' -bool false
      launchctl disable "user/$UID/com.apple.assistantd"
      launchctl disable "gui/$UID/com.apple.assistantd"
      sudo launchctl disable 'system/com.apple.assistantd'
      launchctl disable "user/$UID/com.apple.Siri.agent"
      launchctl disable "gui/$UID/com.apple.Siri.agent"
      sudo launchctl disable 'system/com.apple.Siri.agent'
      defaults write com.apple.SetupAssistant 'DidSeeSiriSetup' -bool True
      defaults write com.apple.systemuiserver 'NSStatusItem Visible Siri' 0
      defaults write com.apple.Siri 'StatusMenuVisible' -bool false
      defaults write com.apple.Siri 'UserHasDeclinedEnable' -bool true
      defaults write com.apple.assistant.support 'Siri Data Sharing Opt-In Status' -int 2
      # disables various remote connections
      sudo launchctl disable 'system/com.apple.tftpd'
      sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
      sudo launchctl disable system/com.apple.telnetd

      # Avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };
}
