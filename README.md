# NixOS

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

These are my NixOS/macOS Nix setup.

| NixOS                                                     | macOS                                                   |
| --------------------------------------------------------- | ------------------------------------------------------- |
| <img src="screenshots/linux.png" width="350" alt="macOS"> | <img src="screenshots/mac.png" width="350" alt="NixOS"> |

## Common Features

- User environment and dotfiles management with
  [`home-manager`](https://github.com/nix-community/home-manager).
- CLI-ready workflow with
  [`fish`](https://github.com/fish-shell/fish-shell),
  [`tmux`](https://github.com/tmux/tmux),
  [`git`](https://git-scm.com/),
  [`fish`](https://fishshell.com/),
  [`gpg`](https://gnupg.org/),
  [`ssh`](https://www.openssh.com/),
  [`curl`](https://curl.se/),
  [`rsync`](https://rsync.samba.org/),
  and power tools like
  [`bat`](https://github.com/sharkdp/bat),
  [`zoxide`](https://github.com/ajeetdsouza/zoxide),
  [`eza`](https://eza.rocks/),
  [`bottom`](https://clementtsang.github.io/bottom),
  [`broot`](https://dystroy.org/broot/),
  [`fzf`](https://github.com/junegunn/fzf),
  [`yazi`](https://yazi-rs.github.io/),
  [`ripgrep`](https://github.com/BurntSushi/ripgrep),
  [`fd`](https://github.com/sharkdp/fd),
  [`sd`](https://github.com/chmln/sd),
  [`jq`](https://jqlang.github.io/jq/),
  [`just`](https://just.systems/),
  [`lazygit`](https://github.com/jesseduffield/lazygit),
  [`lazydocker`](https://github.com/jesseduffield/lazydocker),
  [`gh`](https://cli.github.com/),
  and more...
- Developer-ready languages:
  [Nix](https://nixos.org/),
  [Rust](https://rust-lang.org/),
  [Go](https://go.dev/),
  [Python](https://python.org/),
  [Julia](https://julialang.org)
  and [LLVM](https://llvm.org/).
- Easy to develop environments with
  [`nix-shell`](https://nixos.org/manual/nix/stable/command-ref/nix-shell.html)
  [`direnv`](https://direnv.net/),
  and [`devshell`](https://numtide.github.io/devshell/).
  You can put your [soydev](https://storopoli.io/2023-11-10-2023-11-13-soydev/)
  TypeScript/JavaScript/NodeJS stuff here.
- Text editor with [Helix](https://helix-editor.com/) enabled with the following [LSP](https://langserver.org/)s:

  - [`nil`](https://github.com/oxalica/nil): Nix
  - [`bash-language-server`](https://github.com/bash-lsp/bash-language-server): Bash, Fish, Zsh, shell scripts, etc.
  - [`rust-analyzer`](https://rust-analyzer.github.io/): Rust
  - [`gopls`](https://pkg.go.dev/golang.org/x/tools/gopls): Go
  - [`julia`](https://github.com/julia-vscode/LanguageServer.jl): Julia
  - [`taplo`](https://taplo.tamasfe.dev/): TOML
  - [`yaml-language-server`](https://github.com/redhat-developer/yaml-language-server): YAML
  - [`ruff-lsp`](https://github.com/astral-sh/ruff-lsp): Python
  - [`marksman`](https://github.com/artempyanykh/marksman): Markdown
  - [`vscode-langservers-extracted`](https://github.com/hrsh7th/vscode-langservers-extracted): HTML, CSS, and JSON
  - [`texlab`](https://github.com/latex-lsp/texlab): $\LaTeX$
  - [`ltex-ls`](https://github.com/valentjn/ltex-ls): [LanguageTool](https://languagetool.org/) for Markdown, HTML, and $\LaTeX$.
  - [`typst-lsp`](https://github.com/nvarner/typst-lsp): Typst

- [Catppuccin](https://catppuccin.com) Mocha theme everywhere.
- Archival tools:
  [`gzip`](https://www.gnu.org/software/gzip/),
  [`xz`](https://tukaani.org/xz/),
  `zip`,
  [`lz4`](https://github.com/lz4/lz4),
  [`p7zip`](https://7-zip.org/),
  and [`zstd`](https://facebook.github.io/zstd/).
- CLI entertainment tools:
  [`yt-dlp`](https://github.com/yt-dlp/yt-dlp),
  [`cmus`](https://cmus.github.io/),
  and [`ffmpeg`](https://ffmpeg.org/).
- Publishing and content CLI tools:
  [`qpdf`](https://github.com/qpdf/qpdf),
  [`pandoc`](https://pandoc.org/),
  [`glow`](https://github.com/charmbracelet/glow),
  [`graphicsmagick`](http://www.graphicsmagick.org/),
  [`tectonic`](https://tectonic-typesetting.github.io/),
  and [`typst`](https://typst.app/).
- OS-level adblocking with [`StevenBlack/hosts`](https://github.com/StevenBlack/hosts)
  in the `/etc/hosts`.
- `age`-encrypted secrets with [`ryantm/agenix`](https://github.com/ryantm/agenix)
  with YubiKey support.
  Check the [`secrets/README.md`](secrets/README.md) for details.
- Apps:

  - Bitcoin tools such as [Sparrow wallet](https://sparrowwallet.com/) and [Bisq](https://bisq.network/)
  - Encrypted backup tool with [Cryptomator](https://cryptomator.org/)
  - [Signal messenger](https://signal.org/)
  - Torrenting with [Transmission](https://transmissionbt.com/)
  - Offline password manager with [KeePassXC](https://keepassxc.org/)
  - Screen Recorder with [OBS Studio](https://obsproject.com/)

## NixOS

This is paranoid build with root on `tmpfs`.
This means that everything outside of some directories of `/etc`
and some directories of `/home` will be wiped out.
Read more about this in the [NixOs Paranoid Guide](https://xeiaso.net/blog/paranoid-nixos-2021-07-18)
(this is also a good source [NixOS `tmpfs` as `/home`](https://elis.nu/blog/2020/06/nixos-tmpfs-as-home/)).

### Features

- [XanMod Kernel](https://xanmod.org/)
- [`Hyprland`](https://github.com/hyprwm/Hyprland) Wayland window manager:

  - [`Waybar`](https://github.com/Alexays/Waybar) status bar.
  - [`Nemo`](https://github.com/linuxmint/nemo) file manager.
  - [`Rofi-wayland`](https://github.com/lbonn/rofi) application launcher.
  - [`Mako`](https://github.com/emersion/mako) notification daemon.
  - [`Swaylock-effects`](https://github.com/mortie/swaylock-effects) screen locker.
  - [`NetworkManager`](https://networkmanager.dev/) network management tool.
  - [`Nerdfonts`](https://github.com/ryanoasis/nerd-fonts).

- Apps:
  - [`foot`](https://codeberg.org/dnkl/foot)
  - Docker and Linux VMs with [Podman](https://podman.io/) and [QEMU](https://www.qemu.org/)

- VPN support with [`wireguard`](https://www.wireguard.com/)
- Keyboard customizations with [`keyd`](https://github.com/rvaiya/keyd):
  Caps Lock as Escape (if tapped) and Control (if held).

### How to Install

1. Prepare a
   [64-bit NixOS 23.11 minimal iso image](https://channels.nixos.org/nixos-23.11/latest-nixos-minimal-x86_64-linux.iso)
   and burn it, then enter the live system.
   Suppose I have divided two partitions: `/dev/nvme0n1p1` and `/dev/nvme0n1p2`
1. Format the partitions:

   ```bash
   mkfs.fat -F 32 /dev/nvme0n1p1
   mkfs.ext4 /dev/nvme0n1p2 # or use LUKS with cryptsetup luksFormat /dev/nvme0n1p2 encryptedroot
   ```

1. Mount:

   ```bash
   mount -t tmpfs none /mnt
   mkdir -p /mnt/{boot,nix,etc/nixos}
   mount /dev/nvme0n1p2 /mnt/nix # or LUKS with mount /dev/mapper/encryptedroot /mnt/nix
   mount /dev/nvme0n1p1 /mnt/boot
   mkdir -p /mnt/nix/persist/etc/nixos
   mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos
   ```

1. Generate a basic configuration:

   ```bash
   nixos-generate-config --root /mnt
   ```

1. Clone the repository locally:

   ```bash
   nix-shell -p git
   # recursive for git submodules
   git clone --recursive https://github.com/storopoli/flakes.git /mnt/etc/nixos/flakes
   cd /mnt/etc/nixos/flakes/
   nix develop --extra-experimental-features "nix-command flakes" --extra-experimental-features flakes
   ```

1. Copy `hardware-configuration.nix` from `/mnt/etc/nixos`
   to `/mnt/etc/nixos/flakes/hosts/laptop/hardware-configuration.nix`:

   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/flakes/hosts/laptop/hardware-configuration.nix
   ```

1. Modify the overwritten `hardware-configuration.nix`:

   ```bash
   hx /mnt/etc/nixos/flakes/hosts/laptop/hardware-configuration.nix
   ```

   ```nix
   ...
   # This is just an example
   # Please refer to `https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/#step-4-1-configure-disks`

     fileSystems."/" =
       { device = "none";
         fsType = "tmpfs";
         options = [ "defaults" "size=12G" "mode=755"  ];
       };

     fileSystems."/nix" =
       { device = "/dev/disk/by-uuid/49e24551-c0e0-48ed-833d-da8289d79cdd";
         fsType = "ext4";
       };

     fileSystems."/boot" =
       { device = "/dev/disk/by-uuid/3C0D-7D32";
         fsType = "vfat";
       };

     fileSystems."/etc/nixos" =
       { device = "/nix/persist/etc/nixos";
         fsType = "none";
         options = [ "bind" ];
       };
   ...
   ```

1. remove `/mnt/etc/nixos/flakes/.git`:

   ```bash
   rm -rf .git
   ```

1. Username modification: edit `/mnt/etc/nixos/flakes/flake.nix` to modify **user** variable,
   hostname modification: edit `/mnt/etc/nixos/flakes/hosts/system.nix`
   to modify the **hostName** value in the **networking** property group

1. Use the hash password generated by the `mkpasswd {PASSWORD} -m sha-512`
   command to replace the value of `users.users.<name>.hashedPassword` in
   `/mnt/etc/nixos/flakes/hosts/laptop/wayland/default.nix`
   (there are two places to be edited)

1. Perform install:

   ```bash
   nixos-install --no-root-passwd --flake .#laptop
   ```

1. Reboot

   ```bash
   reboot
   ```

1. Enjoy it!

### How to Update

1. First, update the input in `flake`:

   ```bash
   # update the specified input
   nix flake lock --update-input <foo> <foo>
   # or update all inputs
   nix flake update
   # also you can reclaim storage with
   nix-collect-garbage -d
   ```

1. Then, rebuild and switch to the system after rebuild:

   ```bash
   doas nixos-rebuild boot --flake .#<hostname>
   ```

## macOS

The macOS configs are minimalist in approach
and geared towards enhancing security and privacy.
It uses the best practices described in the
[MacOS Hardening Guide](https://github.com/ataumo/macos_hardening)
and the
[MacOS Security and Privacy Guide](https://github.com/drduh/macOS-Security-and-Privacy-Guide).

### Why not Homebrew?

Honestly, Homebrew is a Ruby bloatware.
It is slow, non-reproducible, and a mess to maintain.

Nix is superior in every way.
It is fast as fuck,
and it is 100% reproducible.
Migrating to new hardware or rebuilding old hardware after a wipe is a breeze.

### Features

- Tiling window manager with
  [yabai](https://github.com/koekeishiya/yabai) and
  [skhd](https://github.com/koekeishiya/skhd).

- Apps:
  - [Alacritty](https://alacritty.org/)
  - [Brave](https://brave.com/) with [Tor Browser](https://www.torproject.org/)
    also available
  - Docker and Linux VMs with [UTM](https://mac.getutm.app/) and [OrbStack](https://orbstack.dev/)
  - Keyboard customization with [Karabiner-Elements](https://karabiner-elements.pqrs.org/):
    Caps Lock as Escape (if tapped) and Control (if held).
  - [Android file transfer](https://www.android.com/filetransfer/) support
  - [ProtonVPN](https://protonvpn.com/)
  - [NetNewsWire](https://netnewswire.com/) for RSS feeds
  - [IINA](https://iina.io/) as the default video player
  - iTunes media keys disabled with [`NoTunes`](https://github.com/tombonez/noTunes)
    and [`cmus`](https://cmus.github.io/)
    as the default music player
    (with the caveat that the media keys works,
    thanks to [`cmus-control`](https://github.com/TheFox/cmus-control))

- Common developer enhancements in Finder and Search
- MacOS privacy and security enhancements
- Debloating of animations

### Prepare your system

Before installing anything you'll need to prepare your system:

1. Don't register an Apple ID
1. Enable Lockdown Mode
1. Disable all Sharing stuff: General > Sharing: Disable All
1. Disable Notifications previews:

   - Notifications > Show Previews: Never
   - Notifications: Disable "Allow notifications when the screen is locked"
   - Lock Screen > Require password immediately

1. Change NTP Server: General > Date & Time > Source: Change to "pool.ntp.org"
1. Set the smart battery saver: Boost mode on AC and Low Power mode on battery
1. Disable Siri:

   - Siri and Spotlight: Disable "Ask Siri"
   - Siri and Spotlight > Siri Suggestions > Disable all

1. Disable Analytics:

   - Privacy and Security > Analytics > Improvements: Disable all
   - Privacy and Security > Apple Advertising > Disable personalized ads
   - Game Center: Disable all

### How to Install

1. Install Xcode Command Line Tools:

   ```bash
   xcode-select --install
   ```

1. Install Nix using the [official installer](https://nixos.org/download.html#nix-install-macos):

   ```bash
   sh <(curl -L https://nixos.org/nix/install) --daemon
   ```

1. Enable Flake support:

   ```bash
   echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf
   ```

1. Install [`nix-darwin`](https://github.com/LnL7/nix-darwin):

   ```bash
   # aarch64
   nix run nix-darwin -- switch --flake .#macbook
   # x86_64
   nix run nix-darwin -- switch --flake .#macbook_x86
   ```

1. Apply changes to your system:

   ```bash
   darwin-rebuild switch --flake .
   ```

### How to Update

1. First, update the input in `flake`:

   ```bash
   # update the specified input
   nix flake lock --update-input <foo> <foo>
   # or update all inputs
   nix flake update
   # also you can reclaim storage with
   nix-collect-garbage -d
   ```

1. Then, rebuild and switch to the system after rebuild:

   ```bash
   nix --experimental-features 'nix-command flakes' build '.#darwinConfigurations.macbook.system'
   nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake .
   # or if nix-command and flakes are enabled:
   nix run nix-darwin -- switch --flake .
   ```
