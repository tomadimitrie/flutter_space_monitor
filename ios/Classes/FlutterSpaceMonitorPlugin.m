#import "FlutterSpaceMonitorPlugin.h"
#import <UIKit/UIKit.h>

@implementation FlutterSpaceMonitorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_space_monitor"
            binaryMessenger:[registrar messenger]];
  FlutterSpaceMonitorPlugin* instance = [[FlutterSpaceMonitorPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"getAvailableSpace" isEqualToString: call.method]) {
    result([self calculateRemainingDiskSpaceOnThisDevice]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSNumber *)calculateRemainingDiskSpaceOnThisDevice {
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [dictionary objectForKey:NSFileSystemFreeSize];
}

@end
