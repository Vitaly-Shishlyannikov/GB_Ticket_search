//
//  TabBarController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 16.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "TabBarController.h"
#import "NewsTableViewController.h"
#import "MapViewController.h"

@implementation TabBarController

- (instancetype) init {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        
        UIViewController *vc = [[UIViewController alloc] init];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:0];
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
        
        MapViewController *mapViewConroller = [[MapViewController alloc] init];
        mapViewConroller.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
        
        NewsTableViewController *newsVC = [[NewsTableViewController alloc] init];
        newsVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:2];
        UINavigationController *newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
        
        self.viewControllers = @[navc, mapViewConroller, newsNC];
        self.tabBar.tintColor = [UIColor greenColor];
        self.selectedIndex = 0;
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end