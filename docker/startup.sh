#! /bin/bash

WAYLAND_SOCKET=$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
echo "Wayland socket should be: $WAYLAND_SOCKET"

if [ -S $WAYLAND_SOCKET ] ; then
    echo "INFO: Wayland socket found!";
else
    echo "ERROR: Wayland socket not found";
    exit -1;
fi

ls -l $WAYLAND_SOCKET

/app/flutter_with_depedencies/build/linux/x64/release/bundle/flutter_with_depedencies

