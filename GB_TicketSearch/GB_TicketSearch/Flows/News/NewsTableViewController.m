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
@property (nonatomic, strong) NSArray *news;
@end

@implementation NewsTableViewController {
    BOOL isFavorites;
}

- (instancetype)initFavoritesNewsViewController {
    self = [super init];
    if(self) {
        isFavorites = YES;
        self.news = [NSArray new];
        self.title = @"Favorite News";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:NewsCellReuseIdentifier];
    }
    return self;
}

- (instancetype)initWithNews:(NSArray *)news {
    self = [super init];
    if(self) {
        _news = news;
        self.title = @"News";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:NewsCellReuseIdentifier];
        self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[APIManager sharedInstance] getNews:^(NSArray * _Nonnull news) {
        _news = news;
    [self.tableView reloadData];
    }];
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
    
    if(isFavorites) {
        cell.favoriteNews = [_news objectAtIndex:indexPath.row];
    } else {
        cell.news = [_news objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    if(!cell) {
//        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsCellReuseIdentifier];
//    }
//    News *article = _news[indexPath.row];
//    cell.titleLabel.text = article.title;
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(isFavorites) return;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с новостью" message:@"Что сделать с выбранной новостью?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    if([[CoreDataHelper sharedInstance] isFavorite:[_news objectAtIndex:indexPath.row]]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavorite:[_news objectAtIndex:indexPath.row]];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavorite:[_news objectAtIndex: indexPath.row]];
        }];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

//
//
//    News *article = _news[indexPath.row];
//    NewsDetailViewController *detailController = [[NewsDetailViewController alloc]initWithArticle:article];
//    [self.navigationController showViewController:detailController sender:self];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
