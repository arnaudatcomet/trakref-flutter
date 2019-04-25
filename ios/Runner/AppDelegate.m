#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

// Import Zendesk for testing use
#import <ZendeskSDK/ZendeskSDK.h>
#include <ZendeskCoreSDK/ZendeskCoreSDK.h>
#include <ZDCChat/ZDCChat.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize Zendesk
    [ZDCChat initializeWithAccountKey:@"1yFNgZ6kod4ZkkOuQFcp7rpbFD5WVBkx"];
    
    [ZDKZendesk initializeWithAppId:@"5cb37f1d2a269a1150ab56965c7ace065e0b480a6234147d" clientId:@"mobile_sdk_client_f4a9ccf9588ab41aae56" zendeskUrl:@"https://arnaud.zendesk.com"];
    [ZDKSupport initializeWithZendesk:[ZDKZendesk instance]];
    // End of initialization
    
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:flutterViewController];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    FlutterMethodChannel* nativeChannel = [FlutterMethodChannel
                                           methodChannelWithName:@"flutter.native/zendesk"
                                           binaryMessenger:flutterViewController];
    __weak  typeof(self) weakSelf = self;
    [nativeChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"showZDChat" isEqualToString:call.method]) {
            // Push the zendesk pages
            ZDKHelpCenterUiConfiguration * hcConfig = [[ZDKHelpCenterUiConfiguration alloc] init];
            [hcConfig setHideContactSupport:true];
            
            ZDKRequestUiConfiguration * requestConfig = [ZDKRequestUiConfiguration new];
            requestConfig.subject = @"iOS Ticket";
            UIViewController *helpCenter = [ZDKHelpCenterUi buildHelpCenterOverviewUiWithConfigs:@[requestConfig]];

            self.navigationController.navigationBarHidden = false;
            [self.navigationController pushViewController:helpCenter animated:true];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    [GeneratedPluginRegistrant  registerWithRegistry:self];
    return [super  application:application didFinishLaunchingWithOptions:launchOptions];
    
    /*
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* nativeChannel = [FlutterMethodChannel
                                           methodChannelWithName:@"flutter.native/helper"
                                           binaryMessenger:controller];
    __weak  typeof(self) weakSelf = self;
    [nativeChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"helloFromNativeCode"  isEqualToString:call.method]) {
            NSString *strNative = [weakSelf helloFromNativeCode];
            
            // Try to present something
            UIViewController * blankVC = [[UIViewController alloc] init];
            blankVC.view.frame = controller.view.frame;
            blankVC.view.backgroundColor = [UIColor redColor];
            
            result(strNative);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    [GeneratedPluginRegistrant  registerWithRegistry:self];
    return [super  application:application didFinishLaunchingWithOptions:launchOptions];
    */
    
}
- (NSString *)helloFromNativeCode {
    return  @"Hello From Native IOS Code";
}

@end
