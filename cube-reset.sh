#!/bin/bash

VER=39
OUTPUT_NAME=cube

echo [INFO] Stopping $OUTPUT_NAME...
podman stop $OUTPUT_NAME > /dev/null 2>&1
echo [INFO] Deleting $OUTPUT_NAME image...
toolbox rm $OUTPUT_NAME > /dev/null 2>&1
podman rmi $OUTPUT_NAME:$VER > /dev/null 2>&1
