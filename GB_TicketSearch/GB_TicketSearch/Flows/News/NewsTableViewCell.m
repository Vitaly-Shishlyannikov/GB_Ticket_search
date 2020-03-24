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
        
        _articleImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.75 , 0.0, 90.0, 90.0)];
        _articleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_articleImageView];
        
        _favoriteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_favoriteBtn];
        
        _favoriteBtn.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *buttonXConstraint = [_favoriteBtn.centerXAnchor constraintEqualToAnchor:_articleImageView.centerXAnchor];
        NSLayoutConstraint *buttonTopConstraint = [_favoriteBtn.topAnchor constraintEqualToAnchor:_articleImageView.bottomAnchor];
        buttonTopConstraint.active = YES;
        buttonXConstraint.active = YES;
        
    }
    return self;
}

- (void)setNews:(News *)news {
    _news = news;
    _titleLabel.text = news.title;
    
    NSURL *imgURL = [NSURL URLWithString:news.urlToImage];
    [self downloadImageWithURL:imgURL completionBlock:^(BOOL succeeded, UIImage *image) {
        _articleImageView.image = image;
    }];
}

- (void)setFavoriteNews:(FavoriteNews *)favoriteNews {
    _favoriteNews = favoriteNews;
    _titleLabel.text = favoriteNews.title;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: favoriteNews.urlToImage]];
    _articleImageView.image = [UIImage imageWithData: imageData];
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
          completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
             if ( !error )
              {
                data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [[UIImage alloc] initWithData:data];
                completionBlock(YES,image);
              } else{
                 NSLog(@"Error in downloading image:%@",url);
                 completionBlock(NO,nil);
              }
           }];
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
