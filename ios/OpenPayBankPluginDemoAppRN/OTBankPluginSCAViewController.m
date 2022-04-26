//
//  OTBankPluginSCAViewController.m
//  OpenPayBankPluginDemoAppRN
//
//  Created by Silvio D'Angelo on 26/04/22.
//

#import "OTBankPluginSCAViewController.h"
#import "OTBankPluginReactBridge.h"

@implementation OTBankPluginSCAViewController

-(void)viewWillDisappear:(BOOL)animated
{
  if (OTBankPluginReactBridge.sharedInstance.scaHandler != NULL) {
    OTBankPluginReactBridge.sharedInstance.scaHandler(nil, OTSCARequestedResult_CANCELLED);
    OTBankPluginReactBridge.sharedInstance.scaHandler = nil;
  }
}

@end
