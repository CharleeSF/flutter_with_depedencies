# To build:
# $ docker build --rm -f ./docker/Dockerfile -t flutter_docker .  
# To run:
# If on a wayland linux session:
# $ docker run -e XDG_RUNTIME_DIR=/tmp -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY -v $XDG_RUNTIME_DIR:/tmp flutter_docker
# If on an X session:
# Install and run weston
# $ sudo apt install weston
# $ weston
# This should have opened a grey screen and a socket at $XDG_RUNTIME_DIR/wayland-0
# I another terminal run
# $ docker run -e XDG_RUNTIME_DIR=/tmp -e WAYLAND_DISPLAY=wayland-0 -v $XDG_RUNTIME_DIR:/tmp flutter_docker
# You should now see output on the grey screen

# Install Operating system and dependencies
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Dependencies for flutter (non-linux-specific)
RUN apt-get update 
RUN apt-get install -y curl git wget unzip zip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback python3 xz-utils

RUN curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.8-stable.tar.xz | tar -xJf -

ENV PATH "$PATH:/flutter/bin"

# Dependencies for flutter linux build
RUN apt-get install -y clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev

# Check if flutter works (not necessary for installation)
RUN flutter doctor -v

WORKDIR /app
RUN git clone --depth=1 --branch=flutter_in_docker https://github.com/CharleeSF/flutter_with_depedencies.git /app/flutter_with_depedencies
WORKDIR /app/flutter_with_depedencies

RUN flutter build linux

COPY docker/startup.sh .

ENV DISPLAY=":0"

CMD ["./startup.sh"]