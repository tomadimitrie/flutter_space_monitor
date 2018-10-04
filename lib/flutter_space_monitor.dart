import 'dart:async';

import 'package:flutter/services.dart';

class FlutterSpaceMonitor {
  static const MethodChannel _channel =
      const MethodChannel('flutter_space_monitor');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<double> get availableSpace async {
    return _channel.invokeMethod('getAvailableSpace');
  }

}
