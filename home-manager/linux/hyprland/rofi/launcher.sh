#!/usr/bin/env bash

theme="launcher_theme"
dir="$HOME/.config/rofi"

# catppuccin
ALPHA="#00000000"
BG="#1E1E2E"
FG="#1A1B26"
SELECT="#C0CAF5"
ACCENT="#1A1B26"

# overwrite colors file
cat >"$dir"/colors.rasi <<-EOF
	/* colors */

	* {
	  al:  $ALPHA;
	  bg:  $BG;
	  se:  $SELECT;
	  fg:  $FG;
	  ac:  $ACCENT;
	}
EOF

rofi -no-lazy-grab -show drun -modi drun -theme "$dir/$theme"
