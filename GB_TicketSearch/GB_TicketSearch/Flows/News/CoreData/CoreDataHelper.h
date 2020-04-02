//
//  CoreDataHelper.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 20.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FavoriteNews+CoreDataClass.h"
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(News*)article;
- (NSArray*)favorites;
- (void)addToFavorite:(News*)article;
- (void)removeFromFavorite:(News*)article;


@end

NS_ASSUME_NONNULL_END
