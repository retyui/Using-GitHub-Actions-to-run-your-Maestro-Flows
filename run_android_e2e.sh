#!/bin/bash

set -x # all executed commands are printed to the terminal

TMP_FILE=_fail_proccess

# Start video record
$ANDROID_HOME/platform-tools/adb shell screenrecord /sdcard/video_record.mp4 & echo $! > video_record.pid
sleep 3

APP_ID=com.retyui.myapp

# Retry 3 times before the steps actually fails
(echo "===== Run E2E Attempt:  1 ====" &&             $HOME/.maestro/bin/maestro test .maestro/ --env=APP_ID="$APP_ID" --format=junit --output report1.xml) || \
(echo "===== Run E2E Attempt:  2 ====" && sleep 20 && $HOME/.maestro/bin/maestro test .maestro/ --env=APP_ID="$APP_ID" --format=junit --output report2.xml) || \
(echo "===== Run E2E Attempt:  3 ====" && sleep 60 && $HOME/.maestro/bin/maestro test .maestro/ --env=APP_ID="$APP_ID" --format=junit --output report3.xml) || \
(echo "===== Run E2E Step Failed ====" && touch "$TMP_FILE")

# Stop video record process
kill -SIGINT "$(cat video_record.pid)"
sleep 3
rm -rf video_record.pid

# Take screenshot
$ANDROID_HOME/platform-tools/adb shell screencap -p /sdcard/last_img.png
$ANDROID_HOME/platform-tools/adb pull /sdcard/last_img.png

# Move the video from Emulator to Host filesystem
$ANDROID_HOME/platform-tools/adb pull /sdcard/video_record.mp4
$ANDROID_HOME/platform-tools/adb shell rm /sdcard/video_record.mp4

# Debug
echo "::group::Maestro hierarchy"
#     ^^^^^^^^ see: https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#grouping-log-lines
$HOME/.maestro/bin/maestro hierarchy
echo "::endgroup::"


if [ -f "$TMP_FILE" ]; then
  rm -rf "$TMP_FILE"
  echo "3 tries have failed..."
  exit 1
esle
  echo "Success..."
fi
