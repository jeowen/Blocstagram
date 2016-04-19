//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Jason Owen on 3/21/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaTableViewCell.h"

@class Media, MediaFullScreenViewController;

@protocol MediaFullScreenViewControllerDelegate <NSObject>

- (void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

@end
@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) Media *media;
@property (nonatomic, weak) id <MediaFullScreenViewControllerDelegate> delegate;
- (instancetype) initWithMedia:(Media *)media;

- (void) centerScrollView;
 - (void) recalculateZoomScale;

@end