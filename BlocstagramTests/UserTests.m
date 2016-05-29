//
//  UserTests.m
//  Blocstagram
//
//  Created by Jason Owen on 5/26/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import "Media.h"

@interface UserTests : XCTestCase

@end

@implementation UserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testThatInitializationWorks
{
    NSDictionary *sourceDictionary = @{@"id": @"8675309",
                                       @"username" : @"d'oh",
                                       @"full_name" : @"Homer Simpson",
                                       @"profile_picture" : @"http://www.example.com/example.jpg"};
    User *testUser = [[User alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testUser.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testUser.userName, sourceDictionary[@"username"], @"The username should be equal");
    XCTAssertEqualObjects(testUser.fullName, sourceDictionary[@"full_name"], @"The full name should be equal");
    XCTAssertEqualObjects(testUser.profilePictureURL, [NSURL URLWithString:sourceDictionary[@"profile_picture"]], @"The profile picture should be equal");
}

- (void)testThatMediaInitializerWorks
{
      // create a user
//    NSDictionary *sourceUserDictionary = @{@"id": @"8675309",
//                                       @"username" : @"d'oh",
//                                       @"full_name" : @"Homer Simpson",
//                                       @"profile_picture" : @"http://www.example.com/example.jpg"};
//    User *testUser = [[User alloc] initWithDictionary:sourceUserDictionary];
//    
    NSDictionary *sourceDictionary = @{@"id": @"8675309",
                                       @"user" : @{@"id": @"8675309",
                                                   @"username" : @"d'oh",
                                                   @"full_name" : @"Homer Simpson",
                                                   @"profile_picture" : @"http://www.example.com/example.jpg"},
                                       @"mediaURL" : @"https://www.spacetelescope.org/images/archive/top100/",
                                       @"downloadState" : @"successful",
                                       @"caption" : @"Coolest Image in the Universe",
                                       @"mcomments" : @"in celebration of NASA, ESA, and the Hubble Space Telescope",
                                       @"likeState" : @"definitely liked"};
    Media *testMedia = [[Media alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testMedia.user, sourceDictionary[@"user"], @"The user object should be equal");
    XCTAssertEqualObjects(testMedia.mediaURL, sourceDictionary[@"mediaURL"], @"The full name should be equal");

}


@end
