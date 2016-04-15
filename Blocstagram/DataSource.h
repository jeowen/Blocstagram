//
//  DataSource.h
//  Blocstagram
//
//  Created by Jason Owen on 2/19/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

 @class Media;


// create block of code for a completion handler

 typedef void (^NewItemCompletionBlock)(NSError *error);


@interface DataSource : NSObject

//To access to this class call [DataSource sharedInstance]. If the shared instance exists, this method will return it.
// method sharedInstance is in DataSource.m
+(instancetype) sharedInstance;

-(void) deleteRow:(NSIndexPath *) indexPath;

// add instagram client key
+ (NSString *) instagramClientID;


//√This property is readonly to prevent other classes from modifying it. 
@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;

//Let's add a method to DataSource which lets other classes delete a media item:
 - (void) deleteMediaItem:(Media *)item;

//
- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;

 - (void) downloadImageForMediaItem:(Media *)mediaItem;
// for checkpoint, add a method which will move media item to top instead of deleting it
//- (void) moveMediaItemToTop:(Media *) item;

- (void) toggleLikeOnMediaItem:(Media *)mediaItem withCompletionHandler:(void (^)(void))completionHandler;



// property to store token received from web api
@property (nonatomic, strong, readonly) NSString *accessToken;
@end
