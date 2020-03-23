//
//  NewsTableViewCell.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 02.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteNews+CoreDataClass.h"
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell

@property(strong, nonatomic) UILabel *titleLabel;
@property(strong,nonatomic) News *news;
@property(strong,nonatomic) FavoriteNews *favoriteNews;
@property(strong,nonatomic) UIImageView *articleImageView;

@end

NS_ASSUME_NONNULL_END
