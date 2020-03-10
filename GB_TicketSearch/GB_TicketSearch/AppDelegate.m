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
    
    MapViewController *mapViewConroller = [[MapViewController alloc] init];
    
    
    UIViewController *viewController = [[UIViewController alloc]init];
    CGRect imageFrame = windowFrame;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    imageView.image = [UIImage imageNamed:@"News"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [viewController.view setBackgroundColor:[UIColor whiteColor]];
    [viewController.view addSubview:imageView];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mapViewConroller];
       
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
//    [[APIManager sharedInstance] getNews:^(NSArray * _Nonnull news) {
//
//        NewsTableViewController *newsViewController = [[NewsTableViewController alloc] initWithNews:news];
//        [navigationController.topViewController removeFromParentViewController];
//        [navigationController showViewController:newsViewController sender:self];
//        sleep(2);
//    }];
      
    return YES;
}

@end
