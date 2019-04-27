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
    /*
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
            [self.navigationController pushViewController:helpCenter animated:true];
        }
        else if ([@"showZDTicket" isEqualToString:call.method]) {
            NSString * message = call.arguments[@"Message"];
            NSString * subject = call.arguments[@"Subject"];
            
            ZDKCreateRequest * request = [[ZDKCreateRequest alloc] init];
            request.subject = subject;
            request.requestDescription = message;
            request.tags = [NSArray array];
            
            ZDKRequestProvider * provider = [[ZDKRequestProvider alloc] init];
            [provider createRequest:request withCallback:^(id result, NSError *error) {
                NSLog(@"result %@", [NSString stringWithFormat:@"%@", result]);
                NSLog(@"localizedDescription %@", [NSString stringWithFormat:@"%@", [error localizedDescription]]);
//                result(@"Test");
            }];
        }
        else {
            result(FlutterMethodNotImplemented);
        }
    }];
    */
    
    // Note from Arnaud : create a 'FlutterMethodChannel' instance above will grab all the events for geolocation, which we want to avoid
    [GeneratedPluginRegistrant  registerWithRegistry:self];
    return [super  application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
