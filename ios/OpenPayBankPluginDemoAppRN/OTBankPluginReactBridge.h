//
//  OTBankPluginReactBridge.h
//  OpenPayBankPluginDemoApp
//
//  Created by Silvio D'Angelo on 20/04/22.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>

#import <OTBANKPLUGIN/OTHFManager.h>


NS_ASSUME_NONNULL_BEGIN

@interface OTBankPluginReactBridge : NSObject<RCTBridgeModule>

+(instancetype) sharedInstance;
@property (copy, nullable) OTSCARequestedResultHandler scaHandler;
@property UIViewController* presentedVC;

@end

NS_ASSUME_NONNULL_END
