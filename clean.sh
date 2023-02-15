#!/bin/sh

# This script cleans up the stream files old enough.

path=/path/to/nextcloud/camera/files
time="31 days ago"
time_folder=$(date +"%Y-%m-%d" -d "$time")

archive_camera() {
	camera=$1

	echo "Clean up stream files for camera $camera at $time_folder"
	rm -rf $path/$camera/$time_folder

	echo "Update Nextcloud index after clean up for camera $camera"
	php -f /var/www/nextcloud/occ files:scan --path /camera/files/$camera --shallow
}

archive_camera Camera1
archive_camera Camera2
archive_camera Camera3
