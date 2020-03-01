//
//  AppDelegate.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 14.02.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "AppDelegate.h"
#import "CountriesViewController.h"
#import "APIManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    CGRect windowFrame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:windowFrame];
    
    CountriesViewController *mainViewController = [[CountriesViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    
    [[APIManager sharedInstance]getNews:^(NSArray * _Nonnull news) {
        NSLog(@"%@",news);
    }];
    
    return YES;
}

@end
