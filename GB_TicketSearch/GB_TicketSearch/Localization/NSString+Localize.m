//
//  NSString+Localize.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 09.04.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "NSString+Localize.h"

@implementation NSString(Localization)

- (NSString *)localize {
    return NSLocalizedString(self, "");
}

@end
