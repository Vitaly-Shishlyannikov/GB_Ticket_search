//
//  NewsPageViewController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 31.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "NewsPageViewController.h"

@interface NewsPageViewController ()

@property(strong,nonatomic) UIPageControl *pageControl;
@property(strong,nonatomic) NSArray *news;
@property(nonatomic) NSInteger tmpIndex;

@end

@implementation NewsPageViewController

- (instancetype) initWithNews:(NSArray*)news atIndex:(NSInteger)index transitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<UIPageViewControllerOptionsKey,id> *)options {
    
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    
    if(self) {
        _news = news;
        _tmpIndex = index;
        self.view.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        NewsDetailViewController *firstDetailVC = [self detailViewControllerAtIndex:index];
        [self setViewControllers:@[firstDetailVC] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 776, self.view.bounds.size.width, 37)];
        _pageControl.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_pageControl];
    }
    return self;
}

- (NewsDetailViewController *)detailViewControllerAtIndex:(NSInteger)index {
    if(index < 0 || index >= _news.count) {
        return nil;
    }
    return [[NewsDetailViewController alloc] initWithArticle:[_news objectAtIndex:index] forIndex:index];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((NewsDetailViewController *)viewController).index;
    index += 1;
    
    return [self detailViewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((NewsDetailViewController *)viewController).index;
    index -= 1;
    
    return [self detailViewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return _news.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return _tmpIndex;
}

@end
