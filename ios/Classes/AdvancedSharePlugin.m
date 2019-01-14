#import "AdvancedSharePlugin.h"
#import <advanced_share/advanced_share-Swift.h>

@implementation AdvancedSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAdvancedSharePlugin registerWithRegistrar:registrar];
}
@end
