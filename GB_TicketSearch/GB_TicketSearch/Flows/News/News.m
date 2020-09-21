//
//  News.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 01.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "News.h"

@implementation News

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        _author = [dictionary valueForKey:@"author"];
        _title = [dictionary valueForKey:@"title"];
        _content = [dictionary valueForKey:@"content"];
        _url = [dictionary valueForKey:@"url"];
        _urlToImage = [dictionary valueForKey:@"urlToImage"];
    }
    return self;
}

@end
