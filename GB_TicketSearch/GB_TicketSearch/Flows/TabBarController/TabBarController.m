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
#import "PhotoViewController.h"
#import "NSString+Localize.h"

@implementation TabBarController

- (instancetype) init {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        
        PhotoViewController *photosVC = [[PhotoViewController alloc]init];
        photosVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"tabItem_photos" localize] image:[UIImage systemImageNamed:@"photo.on.rectangle"] tag:0];
        
        MapViewController *mapViewConroller = [[MapViewController alloc] init];
        mapViewConroller.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"tabItem_map" localize] image:[UIImage systemImageNamed:@"map"] tag:1];
        
        NewsTableViewController *newsVC = [[NewsTableViewController alloc] init];
        newsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"tabItem_news" localize] image:[UIImage systemImageNamed:@"bubble.left"] tag:2];
        UINavigationController *newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
        
        NewsTableViewController *favoriteViewController = [[NewsTableViewController alloc] initFavoritesNewsViewController];
        favoriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"tabItem_favoriteNews" localize] image:[UIImage systemImageNamed:@"plus.bubble"] tag:3];
        UINavigationController *favoriteNewsNC = [[UINavigationController alloc] initWithRootViewController:favoriteViewController];
        
        self.viewControllers = @[photosVC, mapViewConroller, newsNC, favoriteNewsNC];
        self.tabBar.tintColor = [UIColor blueColor];
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
