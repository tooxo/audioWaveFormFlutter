#import "AudiowaveformFlutterPlugin.h"
#if __has_include(<audiowaveformFlutter/audiowaveformFlutter-Swift.h>)
#import <audiowaveformFlutter/audiowaveformFlutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "audiowaveformFlutter-Swift.h"
#endif
@implementation AudiowaveformFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAudiowaveformFlutterPlugin registerWithRegistrar:registrar];
}
@end
