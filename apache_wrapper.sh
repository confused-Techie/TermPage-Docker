#!/bin/bash
./apache_startup -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start apache_startup process: $status"
  exit 1
fi

# Naive check runs checks once a minute to see if the process exited.
# if it detects that the process has exited it exits with an error.
while sleep 60; do
  ps aux | grep apache_startup | grep -q -v grep
  PROCESS_STATUS=$?
  if [ $PROCESS_STATUS -ne 0 ]; then
    echo "The startup process has already exited."
    exit 1
  fi
done
