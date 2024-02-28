# LiveKit Flutter Example

The sourcecode is a copy of Livekit's Flutter SDK example code: https://github.com/livekit/client-sdk-flutter/tree/main/example
This app implements a video room using LiveKit's Flutter SDK.

snapcraft.yaml was added for snap packaging.

## Build on Ubuntu Desktop

```sudo snap install snapcraft --classic```

The default stable version was 8.0.3 at time of writing

```snapcraft --verbose```

## Setup on Ubuntu Core with server on Ubuntu Desktop

### Setup livekit server on Ubuntu Desktop

* Install livekit: https://docs.livekit.io/realtime/self-hosting/local/#start-the-server-in-dev-mode
* Install livekit CLI: https://docs.livekit.io/realtime/cli-setup/
* Create and store token somewhere:
```
livekit-cli create-token \
    --api-key devkey --api-secret secret \
    --join --room my-first-room --identity user1 \
    --valid-for 24h
```
* Start livekit server (LAN_ACCESSIBLE_IP is usually starts like 192.168....):
```
livekit-server --dev --bind $LAN_ACCESSIBLE_IP
```

### Install + connect interfaces on Ubuntu Core

Copy the snap to the device.

SSH into the device.

Install dependencies:

```
sudo snap install ubuntu-frame

# Instal audio server, pulseaudio or pulse-server
sudo snap install pulseaudio --channel=latest/edge

sudo snap install network-manager
```

Install snap:

```
sudo snap install $SNAP_NAME --devmode
```

Connect interfaces for snap:

```
sudo snap connect flutter-with-dependencies:wayland ubuntu-frame:wayland
sudo snap connect flutter-with-dependencies:audio-playback $YOUR_AUDIO_SERVER_SNAP:audio-playback # YOUR_AUDIO_SERVER_SNAP=pulseaudio for example
sudo snap connect flutter-with-dependencies:audio-record $YOUR_AUDIO_SERVER_SNAP:audio-record
sudo snap connect flutter-with-dependencies:network-manager network-manager:service # Double check the exact values
```

Maybe you have to connect interfaces from your audio server too. Check with
```
snap connections $YOUR_AUDIO_SERVER_SNAP
```

### Configure and run

```
sudo snap set flutter-with-dependencies url="ws://$LAN_ACCESSIBLE_IP_OF_LIVEKIT_SERVER_RUNNER:7880"
sudo snap set flutter-with-dependencies token=$EARLIER_GENERATED_LIVEKIT_TOKEN
sudo snap set flutter-with-dependencies autojoin="YES"
```

The livekit app should start and join the server.