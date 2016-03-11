//
//  LoginViewController.h
//  Blocstagram
//
//  Created by Jason Owen on 3/10/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController


// it is frequent to use variables that are accessible from anywhere. Using extern is the most frequent workaround for the lack of "class variables" (like those declared with static in Java) in Objective-C. It allows you to expand the scope in which you can reference a symbol beyond the compilation unit where it is declared, essentially by promising that it will be defined somewhere by someone.
//any object that needs to be notified when an access token is obtained will use this string.
extern NSString *const LoginViewControllerDidGetAccessTokenNotification;

@end