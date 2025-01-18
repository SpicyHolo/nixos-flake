{ config, pkgs, ... }:
let
  renameImagesScript = pkgs.writeShellScriptBin "rename-images" ''
    # Get the largest number among .jpg and .png files
    max_num=$(ls *.jpg *.png 2>/dev/null | sed -E 's/[^0-9]*([0-9]+)\..*/\1/' | sort -n | tail -1)

    # Determine the zero-padding length
    pad_length=${#max_num}

    # Rename files with the zero-padded prefix
    for file in *.jpg *.png; do
      if [[ -f $file ]]; then
        base=$(basename "$file")
        extension="${file##*.}"
        number=$(echo "$base" | sed -E 's/[^0-9]*([0-9]+)\..*/\1/')
        prefix=$(echo "$base" | sed -E 's/^(.*)[0-9]+\..*/\1/')
        new_number=$(printf "%0${pad_length}d" "$number")
        mv "$file" "${prefix}${new_number}.${extension}"
      fi
    done
  '';
in
{
  home.packages = [
    renameImagesScript
  ];
}

