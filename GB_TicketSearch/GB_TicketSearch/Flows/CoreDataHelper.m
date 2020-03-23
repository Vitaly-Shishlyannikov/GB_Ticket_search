//
//  CoreDataHelper.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 20.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()
@property(nonatomic,strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong) NSManagedObjectModel *managedObjectModel;
@end

@implementation CoreDataHelper

+ (instancetype)sharedInstance {
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"news" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    if(!store) {
        abort();
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
}

- (void)save {
    NSError *error;
    [_managedObjectContext save: &error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (FavoriteNews*)faroriteFromNews:(News*)article {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"FavoriteNews"];
    request.predicate = [NSPredicate predicateWithFormat:@"title == %@ AND author == %@ AND content == %@ AND url == %@ AND urlToImage == %@", article.title, article.author, article.content, article.url, article.urlToImage];
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavorite:(News *)article {
    return [self faroriteFromNews:article] != nil;
}

- (void)addToFavorite:(News *)article {
    FavoriteNews *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteNews" inManagedObjectContext:_managedObjectContext];
    favorite.title = article.title;
    favorite.author = article.author;
    favorite.content = article.content;
    favorite.url = article.url;
    favorite.urlToImage = article.urlToImage;
    [self save];
}

- (void)removeFromFavorite:(News *)article {
    FavoriteNews *favorite = [self faroriteFromNews:article];
    if(favorite){
        [_managedObjectContext deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:NO]];
    return [_managedObjectContext executeFetchRequest:request error:nil];
}

@end
