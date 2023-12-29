#!/bin/bash

TMP_NAME=cube-create
VER=39
OUTPUT_NAME=cube

# Creating Toolbox
echo [INFO] Creating $OUTPUT_NAME:$VER...
toolbox create $TMP_NAME -i fedora-toolbox:$VER -y > /dev/null 2>&1

# Updating
echo [INFO] Updating toolbox...
toolbox run -c $TMP_NAME sudo dnf update -y > /dev/null 2>&1

# Installing packages
echo [INFO] Enabling external repos...
toolbox run -c $TMP_NAME sudo dnf copr enable varlad/helix -y > /dev/null 2>&1
echo [INFO] Installing ALL dnf packages...
toolbox run -c $TMP_NAME sudo dnf install go helix clang-tools-extra nodejs ninja-build clang gtk3-devel cmake -y > /dev/null 2>&1
echo [INFO] Updating npm...
toolbox run -c $TMP_NAME sudo npm install -g npm@latest > /dev/null 2>&1
echo [INFO] Installing npm packages...
toolbox run -c $TMP_NAME sudo npm install -g typescript typescript-language-server vscode-langservers-extracted yarn > /dev/null 2>&1
echo [INFO] Installing Flutter...
toolbox run -c $TMP_NAME curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.3-stable.tar.xz > /dev/null 2>&1
toolbox run -c $TMP_NAME tar xf ./flutter_linux_3.16.3-stable.tar.xz
toolbox run -c $TMP_NAME sudo cp flutter /usr/local/flutter -r
toolbox run -c $TMP_NAME sudo chown -R $USER:$USER /usr/local/flutter
echo [INFO] Cleaning up Flutter install...
toolbox run -c $TMP_NAME sudo rm flutter_linux_3.16.3-stable.tar.xz
toolbox run -c $TMP_NAME sudo rm flutter -r

# Export image
echo [INFO] Exporting to $OUTPUT_NAME:$VER...
podman commit $TMP_NAME $OUTPUT_NAME:$VER > /dev/null 2>&1

# Cleanup
echo [INFO] Cleaning up...
podman stop $TMP_NAME > /dev/null 2>&1
toolbox rm $TMP_NAME

echo [INFO] Done!
