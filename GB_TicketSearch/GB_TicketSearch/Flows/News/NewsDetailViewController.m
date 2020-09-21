//
//  NewsDetailViewController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 02.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "NewsDetailViewController.h"


@interface NewsDetailViewController ()
@property (nonatomic, strong) News *article;
@end

@implementation NewsDetailViewController

- (instancetype)initWithArticle:(News*)article forIndex:(NSInteger)index {
    self = [super init];
    if(self) {
        _index = index;
        _article = article;
        self.title = article.title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect imageFrame = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: _article.urlToImage]];
    imageView.image = [UIImage imageWithData: imageData];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    CGRect contentFrame = CGRectMake(0.0, CGRectGetMaxY(imageFrame) - 50.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2);
    UILabel *contentView = [[UILabel alloc] initWithFrame:contentFrame];
    contentView.numberOfLines = 0;
    contentView.font = [UIFont systemFontOfSize:20.0 weight: UIFontWeightMedium];
    contentView.text = _article.content;
    [self.view addSubview:contentView];
    
    CGRect linkButtonFrame = CGRectMake(0.0, [UIScreen mainScreen].bounds.size.height / 1.2, [UIScreen mainScreen].bounds.size.width, 30.0);
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [linkButton setTitle:_article.url forState:UIControlStateNormal];
    linkButton.backgroundColor = [UIColor clearColor];
    linkButton.tintColor = [UIColor blueColor];
    linkButton.frame = linkButtonFrame;
    [linkButton addTarget:self action:@selector(openLinkInSafari:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:linkButton];
}

- (void)openLinkInSafari:(UIButton *)sender {
      NSURL *url = [[ NSURL alloc] initWithString: _article.url ];
      [[UIApplication sharedApplication] openURL:url];
}
 
@end
