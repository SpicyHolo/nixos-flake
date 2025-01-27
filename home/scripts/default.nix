{ config, pkgs, ... }:

let
  renameImagesScript = pkgs.writeShellScriptBin "rename-images" ''
  max_num=''$(ls | sed -n 's/[^0-9]*\([0-9]\+\).*/\1/p' | sort -n | tail -n 1)

  # If no image files are found, exit
    if [ -z "''$max_num" ]; then
      echo "No .jpg, .JPG, .png, or .PNG files found."
      exit 1
    fi

  # Determine the number of digits needed for zero-padding
    pad_length=''${#max_num}

  # Rename files with the zero-padded prefix
    for file in *.{jpg,JPG,png,PNG}; do
      if [[ -f ''$file ]]; then
        # Extract the extension and base name (without the extension)
        extension="''${file##*.}"
        base="''${file%.*}"

        # Extract the number part from the base name
        number=''$(echo "''$base" | sed -E 's/[^0-9]*([0-9]+)[^.]*''$/\1/')
        # Extract the prefix (part before the number)
        prefix=''$(echo "''$base" | sed -E 's/([0-9]+)[^.]*''$/\1/')

        # Format the new number with zero padding
        new_number=''$(printf "%0''${pad_length}d" "''$number")

        # Rename the file if the number differs
        if [[ "''$new_number" != "''$number" ]]; then
          # Handle renaming correctly by preserving the extension
          mv "''$file" "''${base%''$number*}''$new_number.''${extension}"
          echo "Renamed ''$file to ''${base%''$number*}''$new_number.''${extension}"
        fi
      fi
    done
  '';
in
{
  imports = [ 
    ./dunst
  ];
  
  home.packages = [
    renameImagesScript
  ];
}

