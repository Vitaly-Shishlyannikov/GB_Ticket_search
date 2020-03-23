//
//  NewsTableViewCell.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 02.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, [UIScreen mainScreen].bounds.size.width * 0.7, 120.0)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:20.0 weight: UIFontWeightMedium];
        [self.contentView addSubview:_titleLabel];
        
        CGRect imageFrame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.75 , 0.0, 100.0, 100.0);
        _articleImageView = [[UIImageView alloc] initWithFrame:imageFrame];
        _articleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_articleImageView];
    }
    return self;
}

- (void)setNews:(News *)news {
    _news = news;
    _titleLabel.text = news.title;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.urlToImage]];
    _articleImageView.image = [UIImage imageWithData: imageData];
}

- (void)setFavoriteNews:(FavoriteNews *)favoriteNews {
    _favoriteNews = favoriteNews;
    _titleLabel.text = favoriteNews.title;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: favoriteNews.urlToImage]];
    _articleImageView.image = [UIImage imageWithData: imageData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
