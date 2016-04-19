//
//  ImageLibraryViewController.h
//  Blocstagram
//
//  Created by Jason Owen on 4/18/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageLibraryViewController;

@protocol ImageLibraryViewControllerDelegate <NSObject>

- (void) imageLibraryViewController:(ImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage *)image;

@end

@interface ImageLibraryViewController : UICollectionViewController

@property (nonatomic, weak) NSObject <ImageLibraryViewControllerDelegate> *delegate;

@end
