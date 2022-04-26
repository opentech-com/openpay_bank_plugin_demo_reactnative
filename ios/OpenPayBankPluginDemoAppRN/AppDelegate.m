#import "AppDelegate.h"
#import "OTBankPluginReactBridge.h"
#import "OTBankPluginSCAViewController.h"

#import <OTBANKPLUGIN/OTHFManager.h>

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

#ifdef FB_SONARKIT_ENABLED
#import <FlipperKit/FlipperClient.h>
#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>

static void InitializeFlipper(UIApplication *application) {
  FlipperClient *client = [FlipperClient sharedClient];
  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
  [client addPlugin:[FlipperKitReactPlugin new]];
  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
  [client start];
}
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef FB_SONARKIT_ENABLED
  InitializeFlipper(application);
#endif

  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
#if RCT_DEV
  [bridge moduleForClass:[RCTDevLoadingView class]];
#endif
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"OpenPayBankPluginDemoAppRN"
                                            initialProperties:nil];

  if (@available(iOS 13.0, *)) {
      rootView.backgroundColor = [UIColor systemBackgroundColor];
  } else {
      rootView.backgroundColor = [UIColor whiteColor];
  }

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];



  NSError * error = nil;

  NSBundle *amazingBundle = [NSBundle bundleForClass:[self class]];
  NSString * path = [amazingBundle.bundlePath stringByAppendingPathComponent:@"Licenses"];
  NSString* filename = @"openpaybankplugin-sci-demoapp-github-ios";
  path = [path stringByAppendingPathComponent:filename];
  path = [path stringByAppendingString:@".opbp"];
  // plugin configuration.
  BOOL done = [OTHFManager configureWithFile:path withError:&error];
  if(!done || error){
    NSLog(@"Loading config file with path:%@ Error: %@", path, error);
    return YES;
  }else{
    NSLog(@"Config file with path:%@ loaded correctly", path);
  }

  [OTHFManager setScaRequestedHandler:^(UIViewController* otvc, NSString * _Nonnull scaPayload, OTSCARequestedResultHandler  _Nonnull othfHandler) {
    OTBankPluginReactBridge.sharedInstance.scaHandler = othfHandler;

    NSLog(@"scaRequestedHandler invocation!");

    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];

    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                moduleName: @"Sca"
                         initialProperties:
     @{
      @"scaPayload" : scaPayload

    }
                             launchOptions: nil];
    UIViewController *vc = [[OTBankPluginSCAViewController alloc] init];

    vc.view = rootView;
    [otvc presentViewController:vc animated:YES completion:NULL];

    OTBankPluginReactBridge.sharedInstance.presentedVC = vc;
  }];
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
