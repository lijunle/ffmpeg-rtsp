#!/bin/sh

# This script dumps camera streams to camera's Current folder.

camera=$1

if [ "$camera" = "Camera1" ]; then
	input=rtsp://192.168.1.101:554
elif [ "$camera" = "Camera2" ]; then
	input=rtsp://admin:@192.168.1.102:554
elif [ "$camera" = "Camera3" ]; then
	input=rtsp://user:pass@192.168.1.103:554
else
	echo "Provide a valid camera name: $0 <camear-name>"
	exit 1
fi

/usr/bin/ffmpeg -i $input \
	-c copy \
	-f segment \
	-strftime 1 \
	-strftime_mkdir 1 \
	-segment_time 60 \
	-reset_timestamps 1 \
	/path/to/nextcloud/camera/files/$camera/Current/%Y-%m-%d_%H-%M-%S.mp4
