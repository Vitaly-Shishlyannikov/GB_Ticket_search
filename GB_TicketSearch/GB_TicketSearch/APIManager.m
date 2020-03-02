
//
//  APIManager.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 01.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "APIManager.h"
#import "News.h"

#define API_URL @"http://newsapi.org/v2/top-headlines"
#define API_SOURCES @"techcrunch"
#define API_TOKEN @"06865768ac3c45cb9670aa5c3410c2ff"


@implementation APIManager

+(instancetype)sharedInstance {
    static APIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIManager alloc] init];
    });
    return instance;
}


-(void)load:(NSString *)urlString withCompletion:(void(^)(id _Nullable result))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    });
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
    });
        completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
    }] resume];
}


- (void)getNews: (void(^)(NSArray *news))completion {
    NSString *urlString = [NSString stringWithFormat:@"%@?sources=%@&apiKey=%@", API_URL, API_SOURCES, API_TOKEN];
    [self load:urlString withCompletion:^(id _Nullable result) {
        if(result){
            NSMutableArray *json = [result valueForKey:@"articles"];
            NSMutableArray *newsArray = [NSMutableArray new];
            for (NSDictionary *item in json){
                News *article =[[News alloc] initWithDictionary:item];
                [newsArray addObject:article];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                  completion(newsArray);
            });
        }
    }];
}


@end
