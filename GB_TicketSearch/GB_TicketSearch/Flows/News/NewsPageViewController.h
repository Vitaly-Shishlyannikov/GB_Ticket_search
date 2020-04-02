//
//  NewsPageViewController.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 31.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsPageViewController : UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

- (instancetype) initWithNews:(NSArray*)news atIndex:(NSInteger)index transitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<UIPageViewControllerOptionsKey,id> *)options;

@end

NS_ASSUME_NONNULL_END
