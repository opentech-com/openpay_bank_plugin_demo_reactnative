#import <React/RCTBridgeDelegate.h>
#import <UIKit/UIKit.h>

#if RCT_DEV
#import <React/RCTDevLoadingView.h>
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate>

@property (nonatomic, strong) UIWindow *window;

@end
