//
//  DataSource.m
//  Blocstagram
//
//  Created by Jason Owen on 2/19/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Media.h"
#import "Comment.h"

@interface DataSource (){
    // establishes mediaItems as being accessible to other objects
    NSMutableArray *_mediaItems;
}

//This pattern states that this property can only be modified by the DataSource instance. Instances of other classes can only read from it.

@property (nonatomic, strong) NSMutableArray *mediaItems;

@end


@implementation DataSource

//To access to this class call [DataSource sharedInstance]. If the shared instance exists, this method will return it. If it doesn't, it will be created and then returned. Let's implement the method:

//------------------------------------------>
//The dispatch_once function ensures we only create a single instance of this class. This function takes a block of code and runs it only the first time it's called.

//We define a static variable to hold our shared instance: static id sharedInstance;.
//
//Finally we return the instance: return sharedInstance;.

+ (instancetype) sharedInstance {
    
    //The dispatch_once function ensures we only create a single instance of this class. This function takes a block of code and runs it only the first time it's called.
    static dispatch_once_t once;
    
    //We define a static variable to hold our shared instance: static id sharedInstance;.
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//--------------------------------
// We will create a set of methods designed to generate random data for us when the class gets initialized.
- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self addRandomData];
    }
    
    return self;
}


- (void)deleteRow:(NSIndexPath *)indexPath {
    // delete from self.mediaItems
    [self.mediaItems removeObjectAtIndex:indexPath.row ];
    NSLog(@"in DataSource trying to remove indexPath %@", indexPath);
}

- (void) addRandomData {
    NSMutableArray *randomMediaItems = [NSMutableArray array];
    
    
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        if (image) {
            Media *media = [[Media alloc] init];
            media.user = [self randomUser];
            media.image = image;
            media.caption = [self randomSentence];
            
            NSUInteger commentCount = arc4random_uniform(10) + 2;
            NSMutableArray *randomComments = [NSMutableArray array];
            
            for (int i  = 0; i <= commentCount; i++) {
                Comment *randomComment = [self randomComment];
                [randomComments addObject:randomComment];
            }
            
            media.comments = randomComments;
            media.mediaNumber = i;
            
            
            [randomMediaItems addObject:media];
        }
    }
    
    self.mediaItems = randomMediaItems;
    
}

- (User *) randomUser {
    User *user = [[User alloc] init];
    
    //We use a function called arc4random_uniform(). This function returns a random, non-negative number less than the number supplied to it. We add 2 to the result (so all random data will have at least two characters), and use the result to create strings of random length and sentences of random word count.
    
    user.userName = [self randomStringOfLength:arc4random_uniform(10) + 2];
    
    NSString *firstName = [self randomStringOfLength:arc4random_uniform(7) + 2];
    NSString *lastName = [self randomStringOfLength:arc4random_uniform(12) + 2];
    user.fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return user;
}

- (Comment *) randomComment {
    Comment *comment = [[Comment alloc] init];
    
    comment.from = [self randomUser];
    comment.text = [self randomSentence];
    
    return comment;
}

- (NSString *) randomSentence {
    NSUInteger wordCount = arc4random_uniform(20) + 2;
    
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i  = 0; i <= wordCount; i++) {
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12) + 2];
        [randomSentence appendFormat:@"%@ ", randomWord];
    }
    
    return randomSentence;
}

- (NSString *) randomStringOfLength:(NSUInteger) len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
}
//---------------------------------------

#pragma mark - Key/Value Observing
// add accessor methods, which allow observers (i.e., other objects) to be notified when the content of the property changes

- (NSUInteger) countOfMediaItems {
    return self.mediaItems.count;
}

- (id) objectInMediaItemsAtIndex:(NSUInteger)index {
    return [self.mediaItems objectAtIndex:index];
}

- (NSArray *) mediaItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.mediaItems objectsAtIndexes:indexes];
}

// add mutable accessor methods
- (void) insertObject:(Media *)object inMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems insertObject:object atIndex:index];
}

- (void) removeObjectFromMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems removeObjectAtIndex:index];
}

- (void) replaceObjectInMediaItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_mediaItems replaceObjectAtIndex:index withObject:object];
}

//
- (void) deleteMediaItem:(Media *)item {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    [mutableArrayWithKVO removeObject:item];
}

@end
