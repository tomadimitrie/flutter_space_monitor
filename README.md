# Flutter Space Monitor

[![pub package](https://img.shields.io/pub/v/flutter_space_monitor.svg)](https://pub.dartlang.org/packages/flutter_space_monitor)


A Flutter plugin that reports the available space on the device
Works with iOS and Android

## Instalation

Add the plugin to `pubspec.yaml`:
```yaml
dependencies:
  flutter_space_monitor:
```

## Usage

Import it:

```dart
import 'package:flutter_space_monitor/flutter_space_monitor.dart';
```

Use it:

```dart
final space = await FlutterSpaceMonitor.availableSpace; // returns available space in bytes
```
