//
//  News.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 01.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *author;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *urlToImage;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
