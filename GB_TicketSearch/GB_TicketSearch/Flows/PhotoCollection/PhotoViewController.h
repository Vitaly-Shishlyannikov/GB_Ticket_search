//
//  PhotoViewController.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 16.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;

//- (void)showPicker;

@end

NS_ASSUME_NONNULL_END
