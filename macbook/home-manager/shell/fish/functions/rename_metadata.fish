function rename_metadata
  set folder $argv[1]
  set counter 0
  for file in $folder/*
      # Get the creation date
      set datetime (exiftool -p '$CreateDate' -d "%Y_%m_%d-%H%M%S" $file | awk -F ': ' '{print $1}')

      # Get the file extension
      set ext (string match -r '.*\.(.+)' $file --groups)

      # Create a unique filename
      set new_filename $folder/IMG_$datetime.$ext
      while test -e $new_filename
          # If a file with the same name exists, append a counter
          set counter (math $counter + 1)
          set new_filename $folder/IMG_$datetime\_$counter.$ext
      end

      # Rename the file
      mv -n $file $new_filename
  end
end
