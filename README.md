# FFmpeg + RTSP Integration

This repository contains scripts to redirect RTSP streams into MP4 file by using FFmpeg. It also contains script to move generate MP4 files to archive folder, clean them up after some days.

In my case, the MP4 stream files are under Nextcloud storage so I can view them in my private cloud. There are scripts to scan generated/moved/cleaned files in Nextcloud index.

## Usage

[stream.sh](./stream.sh) redirects the RTSP streams to MP4 files. It accepts a parameter to indicate the camera name. E.g., `sh ./stream.sh Camera1`

[camera@.service](./camera%40.service) is a Systemd unit file. It accepts the camera name and hooks up `stream.sh` as a Systemd service. E.g., `systemctl status camera@Camera1.service`

[scan.sh](./scan.sh) will notify Nextcloud to scan generated MP4 stream files so the index is updated. It is necessary because Nextcloud is not aware underlay filesystem changes. The script will be run by [crontab](./crontab) every two minutes.

[archive.sh](./archive.sh) will move the MP4 stream files to an archive folder with timestamp. It is necessary because FFmpeg only redirect files to a flat folder (i.e., `Current` folder in my script). The script will be run by [crontab](./crontab) at each hour.

[clean.sh](./clean.sh) will clean up the MP4 archive folder older than 31 days. The script will be run by [crontab](./crontab) daily.

In regards to permission, all scripts, crontab and files are owned by `www-data` user. They can be directly accessed by Nextcloud.

## License

MIT License.
