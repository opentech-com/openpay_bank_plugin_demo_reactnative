//
//  OTBankPluginReactBridge.m
//  OpenPayBankPluginDemoApp
//
//  Created by Silvio D'Angelo on 20/04/22.
//

#import "OTBankPluginReactBridge.h"

@implementation OTBankPluginReactBridge

static OTBankPluginReactBridge* sharedInstance;

+(instancetype) sharedInstance
{
  static OTBankPluginReactBridge * _getInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    if (sharedInstance != nil) {
      _getInstance = sharedInstance;
    } else {
      _getInstance = [[OTBankPluginReactBridge alloc] init];
    }
  });
  return _getInstance;
}

+ (BOOL)requiresMainQueueSetup {
  return YES;
}

-(instancetype)init
{
  if (sharedInstance) {
    return sharedInstance;
  }
  self = [super init];
  if (self) {
    sharedInstance = self;
  }
  return self;
}


// To export a module named "OpenPayBankPlugin"
RCT_EXPORT_MODULE(OpenPayBankPlugin);

RCT_EXPORT_METHOD(launch:(NSString *)target options:(NSDictionary *)opts)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"launch Objc %@(%@)", target, opts);
    [OTHFManager launch:target options:opts];
  });
}


RCT_EXPORT_METHOD(scaCompleted:(NSInteger) resultCode withSCAResult:(NSString*)scaResult)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    OTSCARequestedResultHandler handler = [self scaHandler];

    if (handler != NULL) {
      handler(scaResult, resultCode);
      self.scaHandler = NULL;
      [self.presentedVC dismissViewControllerAnimated:YES completion:NULL];
    }
  });
}

@end
