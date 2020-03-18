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
@property(nonatomic) NSInteger tmpIndex;
@property(nonatomic, strong) NSMutableArray *photosArray;

- (void)showPicker;
- (void)insertImageInArray:(UIImage *)image;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _photosArray = [NSMutableArray new];
    for (int i = 0; i < 12; i++) {
        NSString *iStr = [NSString stringWithFormat:@"%d", i];
        UIImage *plusImg = [UIImage systemImageNamed:@"plus.circle"];
        NSArray *onePhotoArray = @[iStr, plusImg];
        [_photosArray addObject: onePhotoArray];
    }
    
    UIView *subViewForSearchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
    [self.view addSubview:subViewForSearchBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20.0;   
    layout.minimumInteritemSpacing = 10.0;
    layout.itemSize = CGSizeMake(100.0, 100.0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height -50) collectionViewLayout:layout];
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

    [subViewForSearchBar addSubview: _searchController.searchBar];
    [self.view addSubview:_collectionView];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if(searchController.searchBar.text) {
        _resultsController.results = [self.photosArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS[cd]%@", searchController.searchBar.text]];
    }
}

#pragma mark - CollectionViewDataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_photosArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    cell.photoView.image = _photosArray[indexPath.item][1];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected %ld", (long)indexPath.item);
    _tmpIndex = indexPath.item;
    [self showPicker];
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
        [self insertImageInArray:image];
        NSLog(@"%@", image.description);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertImageInArray:(UIImage *)image {
    NSString *tmpIndexStr = [NSString stringWithFormat:@"%ld", (long)_tmpIndex];
    [_photosArray replaceObjectAtIndex:_tmpIndex withObject:@[tmpIndexStr, image]];
    [self.collectionView reloadData];
}

@end
