# To build:
# $ docker build --build-arg GITLAB_USERNAME=$YOURGITLABUSERNAME --build-arg GITLAB_TOKEN=$YOURGITLABTOKEN  -f ./docker/Dockerfile -t ssi-image .
# To run:
# $ docker compose -f docker/compose.yml up

# Install Operating system and dependencies
FROM ubuntu:22.04 as builder

ENV DEBIAN_FRONTEND=noninteractive

# Dependencies for flutter (non-linux-specific)
RUN apt-get update 
RUN apt-get install -y curl git wget unzip zip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback python3 xz-utils

# Dependencies for flutter linux build
RUN apt-get install -y clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev

RUN apt-get install -y alsa-utils
RUN apt-get install -y alsa-base pulseaudio
RUN apt-get install -y  libmpv-dev

RUN curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.8-stable.tar.xz | tar -xJf -
RUN git config --global --add safe.directory /flutter

ENV PATH "$PATH:/flutter/bin"

RUN flutter doctor -v

ARG GITLAB_USERNAME
ARG GITLAB_TOKEN
ENV GITLAB_USERNAME=${GITLAB_USERNAME}
ENV GITLAB_TOKEN=${GITLAB_TOKEN}

# Use cache so that submodules can use credentials too?
RUN git clone --branch=add-livekit-dependency https://github.com/CharleeSF/flutter_with_depedencies.git flutter-app

RUN cd flutter-app && flutter build linux

# Stage 2: Runtime Stage
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y strace
RUN apt-get install -y libgtk-3-dev
RUN apt-get install -y alsa-utils
RUN apt-get install -y alsa-base pulseaudio
RUN apt-get install -y  libmpv-dev
RUN apt-get install -y at-spi2-core

RUN groupadd --gid 1234 saltoks \
        && useradd --home-dir /home/saltoks --create-home --uid 1234 \
        --gid 1234 --shell /bin/sh --skel /dev/null saltoks

RUN chmod 777 /home/saltoks

USER saltoks

WORKDIR /home/saltoks

COPY --from=builder /flutter-app/build/linux/x64/release/bundle /home/saltoks

COPY docker/startup.sh .

ENV HOME=/home/saltoks

CMD ["./startup.sh"]