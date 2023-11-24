function ytp
  set -l playlist_id $argv[1]
  set -l yturl "https://www.youtube.com/playlist?list=$playlist_id"
  # echo -e "#!/bin/sh\\nyt-dlp --add-metadata -i --format mp4 --restrict-filenames --sponsorblock-remove all -o '%(playlist_index)s-%(title)s.%(ext)s' --download-archive archive.txt \'$yturl\'" >command.sh
  printf "#!/bin/sh\nyt-dlp --add-metadata -i --format mp4 --restrict-filenames --sponsorblock-remove all -o '%%(playlist_index)s-%%(title)s.%%(ext)s' --download-archive archive.txt '%s'" $yturl >command.sh
  chmod +x command.sh
  ./command.sh
end
