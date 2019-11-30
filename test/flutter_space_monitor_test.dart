import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_space_monitor/flutter_space_monitor.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_space_monitor');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterSpaceMonitor.platformVersion, '42');
  });
}
