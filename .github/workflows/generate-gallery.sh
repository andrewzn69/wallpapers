#!/bin/bash

# easier for debugging
set -x

# create output dir
mkdir -p output

# loop through the subdirectories
for dir in *; do
	if [ -d "$dir" ]; then
		folder_name=$(basename "$dir")
		montage_images=()

		# temp folder for edited images
		tempdir=$(mktemp -d)

		# ensure the temporary directory is deleted
		trap 'rm -r "$tempdir"' EXIT

		# create tempdir to store edited images
		mkdir "$tempdir/resized_images"

		for file in "$dir"/*; do
			if [[ -f "$file" ]]; then
				filename_with_extension="${file##*/}"
				# generating edited images
				convert "$file" \
					-resize 300x300 \
					-fill '#d0d0d0' \
					-bordercolor '#262626' \
					-font 'Ubuntu-Regular' \
					-border 5x30 \
					-gravity South \
					-pointsize 18 \
					-annotate +0-0 \
					"$filename_with_extension" "$tempdir/resized_images/$filename_with_extension"
				montage_images+=("$tempdir/resized_images/$filename_with_extension")
			fi
		done

		if [ "$folder_name" != "output" ]; then
			# create the montage
			montage -background '#262626' \
				-mode concatenate \
				-tile 7x \
				-geometry +5+5 \
				"${montage_images[@]}" "output/$folder_name.png"
		fi

		ls output

		# rm tempdir
		rm -rf "$tempdir"
	fi
done
