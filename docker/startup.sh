#! /bin/bash

WAYLAND_SOCKET=$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
echo "Wayland socket should be: $WAYLAND_SOCKET"

if [ -S $WAYLAND_SOCKET ] ; then
    echo "INFO: Wayland socket found!";
else
    ls -l $WAYLAND_SOCKET
    echo "ERROR: Wayland socket not found";
    exit -1;
fi

ls -l $WAYLAND_SOCKET

ls -l /home/saltoks/straces

strace -f -tt -T -o /home/saltoks/straces/livekit_core1.log /home/saltoks/example

