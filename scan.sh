#!/bin/sh

# This script updates Nextcloud index in camera's Current folder.

scan_camera() {
	camera=$1

	echo "Update Nextcloud index shallowly for camera $camera"
	php -f /var/www/nextcloud/occ files:scan --path /camera/files/$camera/Current --shallow
}

scan_camera Camera1
scan_camera Camera2
scan_camera Camera3
