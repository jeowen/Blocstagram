//
//  Comment.h
//  Blocstagram
//
//  Created by Jason Owen on 2/19/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Comment : NSObject <NSCoding>

@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) User *from;
@property (nonatomic, strong) NSString *text;

- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary;
@end
