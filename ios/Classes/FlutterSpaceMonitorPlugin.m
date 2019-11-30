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

- (NSNumber *) calculateRemainingDiskSpaceOnThisDevice {
  uint64_t totalSpace = 0;
  uint64_t totalFreeSpace = 0;
  NSError *error = nil;  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
  NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];  
  if (dictionary) {  
    NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];  
    NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
    totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
    totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
  } 
  return [NSNumber numberWithUnsignedLongLong:totalFreeSpace];
}

@end
