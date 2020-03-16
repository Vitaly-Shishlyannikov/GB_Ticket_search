//
//  LocationService.h
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 09.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#define kLocationServiceDidUpdateCurrentLocation @"​LocationServiceDidUpdateCurrentLocation"

NS_ASSUME_NONNULL_BEGIN

@interface LocationService : NSObject

- (void)addressFromLocation:(CLLocation *)location withCompletion:(void(^)(NSString *cityName))completion;

@end

NS_ASSUME_NONNULL_END
