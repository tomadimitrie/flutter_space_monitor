package com.example.flutterspacemonitor;

import android.os.Environment;
import android.os.StatFs;

import java.io.File;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterSpaceMonitorPlugin */
public class FlutterSpaceMonitorPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_space_monitor");
    channel.setMethodCallHandler(new FlutterSpaceMonitorPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
      if (call.method.equals("getPlatformVersion")) {
          result.success("Android " + android.os.Build.VERSION.RELEASE);
      } else if (call.method.equals("getAvailableSpace")) {
          result.success(megabytesAvailable());
      } else {
      result.notImplemented();
    }
  }

    public float megabytesAvailable() {
        StatFs stat = new StatFs(Environment.getExternalStorageDirectory().getPath());

        long bytesAvailable = (long)stat.getBlockSize() *(long)stat.getBlockCount();
        long megAvailable   = bytesAvailable / 1048576;
        return megAvailable;
    }
}
