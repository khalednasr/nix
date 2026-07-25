#!/bin/sh
DISTRO_IMAGE="ubuntu:24.04"
INSTALLER="$(realpath "$1")"

if [ ! -f "$INSTALLER" ]; then
    echo "Installer does not exist: $INSTALLER"
    exit 1
fi

read -e -p "Distrobox container name: " -i "xilinx" CONTAINER_NAME

if distrobox list | grep -q "$CONTAINER_NAME"; then
    echo "Container already exists, remove?"
    distrobox rm "$CONTAINER_NAME"
fi

distrobox create \
    -n "$CONTAINER_NAME" \
    -i "$DISTRO_IMAGE" \
    --additional-packages "fish fzf" \
    --additional-packages "libc6-dev-i386" \
    --additional-packages "net-tools" \
    --additional-packages "graphviz" \
    --additional-packages "make" \
    --additional-packages "unzip" \
    --additional-packages "zip" \
    --additional-packages "g++" \
    --additional-packages "libtinfo6" \
    --additional-packages "xvfb" \
    --additional-packages "git" \
    --additional-packages "libncurses5-dev" \
    --additional-packages "libnss3-dev" \
    --additional-packages "libgdk-pixbuf2.0-dev" \
    --additional-packages "libgtk-3-dev" \
    --additional-packages "libxss-dev " \
    --additional-packages "libasound2t64" \
    --additional-packages "openssl" \
    --additional-packages "fdisk " \
    --additional-packages "libsecret-1-dev" \
    --additional-flags "--env _JAVA_AWT_WM_NONREPARENTING=1"


distrobox enter "$CONTAINER_NAME" -- sh $INSTALLER

echo "Installation complete!" 
echo "use:"
echo "    distrobox-enter $CONTAINER_NAME -- distrobox-export --bin <binary-path> --export-path <destination-folder>"
echo "to export binaries to host"
