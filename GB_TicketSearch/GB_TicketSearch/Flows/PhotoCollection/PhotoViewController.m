//
//  PhotoViewController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 16.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionViewCell.h"
#import "ResultsViewController.h"

@interface PhotoViewController () <UISearchResultsUpdating>

@property(nonatomic,strong) UISearchController *searchController;
@property(nonatomic,strong) ResultsViewController *resultsController;
@property(nonatomic, strong) NSMutableDictionary *photosDictionary;

- (void)showPicker;
- (void)insertImageInDict:(UIImage *)image;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _photosDictionary = [NSMutableDictionary new];
    
    UIView *subViewForSearchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
    [self.view addSubview:subViewForSearchBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20.0;   
    layout.minimumInteritemSpacing = 10.0;
    layout.itemSize = CGSizeMake(100.0, 100.0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height -50) collectionViewLayout:layout];
//    _collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"ReuseIdentifier"];
    
    _resultsController = [[ResultsViewController alloc] init];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultsController];
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.layer.borderWidth = 1;
    _searchController.searchBar.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
    CGRect addPhotoButtonFrame = CGRectMake(0, 70, 70, 70);
    UIButton *addPhotoButton = [[UIButton alloc] initWithFrame:addPhotoButtonFrame];
    UIImage *plusImg = [UIImage systemImageNamed:@"plus.circle"];
    [addPhotoButton setBackgroundImage:plusImg forState:UIControlStateNormal];
    [addPhotoButton addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];

    [subViewForSearchBar addSubview:addPhotoButton];
    [subViewForSearchBar addSubview: _searchController.searchBar];
    [self.view addSubview:_collectionView];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if(searchController.searchBar.text) {
        NSArray *allKeys = [_photosDictionary allKeys];
        NSArray *keysResults = [allKeys filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS[cd]%@", searchController.searchBar.text]];
        NSMutableArray *images = [NSMutableArray new];
        for (NSString *key in keysResults) {
            UIImage *image = [_photosDictionary valueForKey:key];
            [images addObject:image];
        }
        _resultsController.results = images;
        [_resultsController.collectionView reloadData];
    }
}

#pragma mark - CollectionViewDataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_photosDictionary count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    NSArray *photos = [_photosDictionary allValues];
    cell.photoView.image = photos[indexPath.item];
    
    return cell;
}

#pragma mark - PickerController

- (void)showPicker {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if(image) {
        [self insertImageInDict:image];
        NSLog(@"%@", image.description);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertImageInDict:(UIImage *)image {
    NSString *hashValue = [NSString stringWithFormat:@"%lu",(unsigned long)image.hash];
    [_photosDictionary setObject:image forKey:hashValue];
    [self.collectionView reloadData];
}

@end
