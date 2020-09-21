//
//  FavoriteNews+CoreDataProperties.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 20.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//
//

#import "FavoriteNews+CoreDataProperties.h"

@implementation FavoriteNews (CoreDataProperties)

+ (NSFetchRequest<FavoriteNews *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
}


@end
