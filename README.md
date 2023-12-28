# Flutter snap package displayed on IoT

Add snapcraft.yaml to create snap package for basic flutter example.

## Install dependencies

```sudo snap install ubuntu-frame --channel=22```

```sudo snap install frame-it --classic```

## Make and install package

* Clone repository
* Install snapcraft 7.5.4
* Build snap package
```snapcraft --verbose```
* Install snap package
```sudo snap install flutter-with-dependencies_0.1_amd64.snap --devmode```

## Do wayland setup?

This is listed in the tutorial of the original example: https://discourse.ubuntu.com/t/packaging-a-flutter-application-demo-as-an-iot-gui/29075 and I did it initially for the example, but I didn't do it again.

```/snap/flutter-with-dependencies/current/bin/setup.sh```

## Connect interface

```snap connect flutter-with-dependencies:wayland ubuntu-frame:wayland```

## Run

```frame-it flutter-with-dependencies```