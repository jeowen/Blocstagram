//
//  DataSource.h
//  Blocstagram
//
//  Created by Jason Owen on 2/19/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

//To access to this class call [DataSource sharedInstance]. If the shared instance exists, this method will return it.
// method sharedInstance is in DataSource.m
+(instancetype) sharedInstance;

-(void) deleteRow:(NSIndexPath *) indexPath;



//√This property is readonly to prevent other classes from modifying it. 
@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;

@end
