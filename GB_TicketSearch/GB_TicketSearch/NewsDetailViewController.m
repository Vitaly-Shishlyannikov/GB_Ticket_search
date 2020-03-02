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

-(instancetype)initWithArticle:(News*)article {
    self = [super init];
    if(self) {
        _article = article;
        self.title = article.title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect contentFrame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2);
    UILabel *contentView = [[UILabel alloc] initWithFrame:contentFrame];
    contentView.numberOfLines = 0;
    contentView.font = [UIFont systemFontOfSize:23.0 weight: UIFontWeightMedium];
    contentView.text = _article.content;
    [self.view addSubview:contentView];
    
    
    CGRect linkButtonFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 1.2, [UIScreen mainScreen].bounds.size.width, 50.0);
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [linkButton setTitle:_article.url forState:UIControlStateNormal];
    linkButton.backgroundColor = [UIColor clearColor];
    linkButton.tintColor = [UIColor blueColor];
    linkButton.frame = linkButtonFrame;
    [linkButton addTarget:self action:@selector(openLinkInSafari:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:linkButton];
    
    
}

-(void)openLinkInSafari:(UIButton *)sender {
      NSURL *url = [[ NSURL alloc] initWithString: _article.url ];
      [[UIApplication sharedApplication] openURL:url];
  }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
