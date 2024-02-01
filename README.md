# LiveKit Flutter Example

The sourcecode is a copy of Livekit's Flutter SDK example code: https://github.com/livekit/client-sdk-flutter/tree/main/example
This app implements a video room using LiveKit's Flutter SDK.

snapcraft.yaml was added for snap packaging.

Unfortunately, the resulting snap does not work as expected.

Issue:
When the client connects to the livekit server with microphone enabled the app freezes.
When the client connects to the livekit server with microphone disabled, video works as expected.
If already connected with microphone disabled, you enable the microphone: app freezes again.

## Reproduction

Run example:

* Install livekit and start server: https://docs.livekit.io/realtime/self-hosting/local/#start-the-server-in-dev-mode
* Install livekit CLI: https://docs.livekit.io/realtime/cli-setup/
* Create token:
```
livekit-cli create-token \
    --api-key devkey --api-secret secret \
    --join --room my-first-room --identity user1 \
    --valid-for 24h
```
* Build + run snap:
```
snapcraft --verbose # I created the snap with snapcraft 7.5.4
sudo snap install --devmode flutter-with-dependencies_0.1_amd64.snap
flutter-with-dependencies
```
* In server URL fill in: ws://127.0.0.1:7880
* In token fill in the output of 'Create token' step (the token after 'access token: ')
* In shared key fill in: devkey
* Click connect

If you are trying to mimic error behavior:
* Leave default options and click join --> App should load video but freeze almost immediately after

If you are trying to mimic behavior without microphone:
* Disable microphone and click join --> App should load video and keep working

## Running linux app without snapp

Note that the app doesn't freeze when running the app in linux without a snap environment.
You should be able to build with these steps in case you want to verify/do debug steps:
```
# 'Install' flutter by cloning and setting path
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:$(pwd)/flutter/bin" # If you want to make persistent, put in .bashrc (or other profile rc)

# Install dependencies
sudo apt-get install -y clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev

# Check installation
flutter doctor

# Build
flutter run --debug # And then select linux
```