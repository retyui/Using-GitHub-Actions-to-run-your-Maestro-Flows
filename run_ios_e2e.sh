#!/bin/bash

set -x # all executed commands are printed to the terminal

TMP_FILE=_fail_proccess

# Start video record
xcrun simctl io booted recordVideo video_record.mov & echo $! > video_record.pid

APP_ID=com.retyui.myapp

# Retry 3 times before the steps actually fails
(echo "===== Run E2E Attempt:  1 ====" &&             $HOME/.maestro/bin/maestro test .maestro/ --env=APP_ID="$APP_ID" --format=junit --output report1.xml) || \
(echo "===== Run E2E Attempt:  2 ====" && sleep 20 && $HOME/.maestro/bin/maestro test .maestro/ --env=APP_ID="$APP_ID" --format=junit --output report2.xml) || \
(echo "===== Run E2E Attempt:  3 ====" && sleep 60 && $HOME/.maestro/bin/maestro test .maestro/ --env=APP_ID="$APP_ID" --format=junit --output report3.xml) || \
(echo "===== Run E2E Step Failed ====" && touch "$TMP_FILE")

# Stop video record process
xcrun simctl io booted screenshot last_img.png
kill -SIGINT "$(cat video_record.pid)"
rm -rf video_record.pid

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
