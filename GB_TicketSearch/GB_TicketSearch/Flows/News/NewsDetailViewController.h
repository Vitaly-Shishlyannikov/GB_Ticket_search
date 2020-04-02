//
//  NewsDetailViewController.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 02.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailViewController : UIViewController

@property(nonatomic)NSInteger index;
- (instancetype)initWithArticle:(News*)article forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
