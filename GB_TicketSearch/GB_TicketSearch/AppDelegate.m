//
//  AppDelegate.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 14.02.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsTableViewController.h"
#import "APIManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    CGRect windowFrame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:windowFrame];
    
    UITableViewController *viewController = [[UITableViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
       
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[APIManager sharedInstance] getNews:^(NSArray * _Nonnull news) {
        NewsTableViewController *newsViewController = [[NewsTableViewController alloc] initWithNews:news];
        [navigationController showViewController:newsViewController sender:self];
    }];
      
    return YES;
}

@end
