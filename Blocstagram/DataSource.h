//
//  DataSource.h
//  Blocstagram
//
//  Created by Jason Owen on 2/19/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

 @class Media;

@interface DataSource : NSObject

//To access to this class call [DataSource sharedInstance]. If the shared instance exists, this method will return it.
// method sharedInstance is in DataSource.m
+(instancetype) sharedInstance;

-(void) deleteRow:(NSIndexPath *) indexPath;



//√This property is readonly to prevent other classes from modifying it. 
@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;

//Let's add a method to DataSource which lets other classes delete a media item:
 - (void) deleteMediaItem:(Media *)item;

// for checkpoint, add a method which will move media item to top instead of deleting it
- (void) moveMediaItemToTop:(Media *) item;

@end
