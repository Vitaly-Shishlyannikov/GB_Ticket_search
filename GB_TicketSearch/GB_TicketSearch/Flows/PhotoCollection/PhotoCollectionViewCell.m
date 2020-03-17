//
//  PhotoCollectionViewCell.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 16.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photoView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        _photoView.backgroundColor = [UIColor lightGrayColor];
        _photoView.bounds = self.contentView.bounds;
        _photoView.center = self.contentView.center;
        
        [self.contentView addSubview:_photoView];
    }
    return self;
}

@end
