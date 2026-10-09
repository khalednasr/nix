#!/bin/sh
DISTRO_IMAGE="ubuntu:24.04"
INSTALLER="$(realpath "$1")"
TMPDIR=/tmp/matlab
DEPS="https://raw.githubusercontent.com/mathworks-ref-arch/container-images/refs/heads/main/matlab-deps/r2026b/ubuntu24.04/base-dependencies-amd64.txt"

if [ ! -f "$INSTALLER" ]; then
    echo "Installer does not exist: $INSTALLER"
    exit 1
fi

read -e -p "Distrobox container name: " -i "matlab" CONTAINER_NAME

if distrobox list | grep -q "$CONTAINER_NAME"; then
    echo "Container already exists, remove?"
    distrobox rm "$CONTAINER_NAME"
fi

distrobox create \
    -n "$CONTAINER_NAME" \
    -i "$DISTRO_IMAGE" \
    --additional-packages "unzip wget"

if [ -d "$TMPDIR" ]; then
    rm -rf $TMPDIR
fi

distrobox enter "$CONTAINER_NAME" -- unzip "$INSTALLER" -d "$TMPDIR"
distrobox enter "$CONTAINER_NAME" -- wget "$DEPS" -O "$TMPDIR/deps.txt"
distrobox enter "$CONTAINER_NAME" -- sudo apt-get update
distrobox enter "$CONTAINER_NAME" -- sudo apt-get install -y $(cat $TMPDIR/deps.txt)
distrobox enter "$CONTAINER_NAME" -- $TMPDIR/install

echo "Installation complete!" 
echo "use:"
echo "    distrobox-enter $CONTAINER_NAME -- distrobox-export --bin bash "--login -c <binary-path>" --export-path <destination-folder>"
echo "to export binaries to host"
echo "then edit the resulting script to wrap the binary in a bash --login -c call"
