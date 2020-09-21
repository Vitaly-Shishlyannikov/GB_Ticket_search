//
//  AppDelegate.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 14.02.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "APIManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect windowFrame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:windowFrame];

    UITabBarController *tabBarController = [[TabBarController alloc] init];
 
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
  
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!error) {
                                  NSLog(@"request authorization succeeded!");
                              }
                          }];
    
    return YES;
}

@end
