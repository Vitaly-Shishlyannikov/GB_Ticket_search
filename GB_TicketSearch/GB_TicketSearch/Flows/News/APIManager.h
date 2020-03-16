//
//  APIManager.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 01.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+(instancetype)sharedInstance;

- (void)getNews:(void(^)(NSArray *news))completion;

@end

NS_ASSUME_NONNULL_END
