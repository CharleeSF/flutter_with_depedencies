# Flutter snap package

Add snapcraft.yaml to create snap package for basic flutter example.

The mediakit package was added by copying flutter dependencies and code snipped from https://pub.dev/packages/media_kit

An attempt was done to add required dependencies to snapcraft.yaml, but it seems incorrect

## Make package

* Clone repository
* Install snapcraft 7.5.4
* Build snap package
```snapcraft --verbose```
* Install snap package
```sudo snap install flutter-with-dependencies_0.1_amd64.snap```
* Run snap package
```flutter-with-dependencies```

## Describing issue

Once mediakit dependency was added with its example the application wouldn't run as snap-package anymore.
It was tested that without snap it does work (by doing ```flutter run --debug``` and selecting linux).