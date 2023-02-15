#!/bin/sh

# This script moves the stream files from Current folder to archive folder.

path=/path/to/nextcloud/camera/files
time="1 hour ago"
time_folder=$(date +"%Y-%m-%d/%H/" -d "$time")
time_prefix=$(date +"%Y-%m-%d_%H-" -d "$time")

archive_camera() {
	camera=$1

	echo "Archive stream files for camera $camera"
	mkdir -p $path/$camera/$time_folder
	mv $path/$camera/Current/$time_prefix* $path/$camera/$time_folder

	echo "Update Nextcloud index after archive for camera $camera"
	php -f /var/www/nextcloud/occ files:scan --path /camera/files/$camera/Current
	php -f /var/www/nextcloud/occ files:scan --path /camera/files/$camera/$time_folder
}

archive_camera Camera1
archive_camera Camera2
archive_camera Camera3
