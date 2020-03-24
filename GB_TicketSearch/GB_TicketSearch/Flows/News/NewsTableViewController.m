//
//  NewsTableViewController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 02.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "NewsTableViewController.h"
#import "APIManager.h"
#import "NewsTableViewCell.h"
#import "NewsDetailViewController.h"
#import "CoreDataHelper.h"

#define NewsCellReuseIdentifier @"​NewsCellIdentifier"

@interface NewsTableViewController ()
@property (nonatomic,strong) NSArray *news;
@property (nonatomic,strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic) BOOL doubleTapped;
@property (nonatomic) NSInteger tmpIndex;
@end

@implementation NewsTableViewController {
    BOOL isFavorites;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if(self) {
        self.title = @"News";
        [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:NewsCellReuseIdentifier];
    }
    return self;
}

- (instancetype)initFavoritesNewsViewController {
    self = [super init];
    if(self) {
        isFavorites = YES;
        self.news = [NSArray new];
        self.title = @"Favorite News";
        [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:NewsCellReuseIdentifier];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[APIManager sharedInstance] getNews:^(NSArray * _Nonnull news) {
        _news = news;
    [self.tableView reloadData];
    }];
    
//    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//    doubleTapGesture.numberOfTapsRequired = 2;
//    [self.tableView addGestureRecognizer:doubleTapGesture];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if(isFavorites) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        _news = [[CoreDataHelper sharedInstance] favorites];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellReuseIdentifier forIndexPath:indexPath];
    if(!cell) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsCellReuseIdentifier];
    }
    
    cell.favoriteBtn.tag = indexPath.row;
    [cell.favoriteBtn addTarget:self action:@selector(openFavoriteMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    if(isFavorites) {
        cell.favoriteNews = [_news objectAtIndex:indexPath.row];
    } else {
        cell.news = [_news objectAtIndex:indexPath.row];
        if([[CoreDataHelper sharedInstance] isFavorite:[_news objectAtIndex:indexPath.row]]) {
            [cell.favoriteBtn setBackgroundImage:[UIImage systemImageNamed:@"star.fill"] forState:UIControlStateNormal];
        } else {
            [cell.favoriteBtn setBackgroundImage:[UIImage systemImageNamed:@"star"] forState:UIControlStateNormal];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    News *article = _news[indexPath.row];
    NewsDetailViewController *detailController = [[NewsDetailViewController alloc]initWithArticle:article];
    [self.navigationController showViewController:detailController sender:self];
}

- (void)openFavoriteMenu: (UIButton*)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с новостью" message:@"Что сделать с выбранной новостью?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    if([[CoreDataHelper sharedInstance] isFavorite:[_news objectAtIndex:sender.tag]]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavorite:[_news objectAtIndex: sender.tag]];
            [self.tableView reloadData];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavorite:[_news objectAtIndex: sender.tag]];
            [self.tableView reloadData];
        }];
    }

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
