//
//  ResultsViewController.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 17.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *results;
- (void)update;

@end

NS_ASSUME_NONNULL_END
