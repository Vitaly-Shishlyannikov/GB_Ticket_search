//
//  FavoriteNews+CoreDataProperties.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 20.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//
//

#import "FavoriteNews+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteNews (CoreDataProperties)

+ (NSFetchRequest<FavoriteNews *> *)fetchRequest;

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *author;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *urlToImage;

@end

NS_ASSUME_NONNULL_END
