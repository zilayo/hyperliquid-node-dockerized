#!/bin/sh

# Remove log files/folders older than 3 days.
find ./node-data/log/* -mtime +3 -type d -exec rm -rf {} \;
