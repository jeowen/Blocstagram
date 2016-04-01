//
//  Media.h
//  Blocstagram
//
//  Created by Jason Owen on 2/19/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LikeButton.h"

typedef NS_ENUM(NSInteger, MediaDownloadState) {
    MediaDownloadStateNeedsImage             = 0,
    MediaDownloadStateDownloadInProgress     = 1,
    MediaDownloadStateNonRecoverableError    = 2,
    MediaDownloadStateHasImage               = 3
};



// line below avoids a circular inclusion (User.h referencing Media.h and vice-versa)
// in general, don't import your own custom classes, instead use the "forward declaration"
@class User;


@interface Media : NSObject <NSCoding>
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, assign) int mediaNumber;
@property (nonatomic, assign) MediaDownloadState downloadState;
@property (nonatomic, assign) LikeState likeState;

 - (instancetype) initWithDictionary:(NSDictionary *)mediaDictionary;

@end
