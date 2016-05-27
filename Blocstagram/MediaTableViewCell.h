//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by Jason Owen on 2/23/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media, MediaTableViewCell, ComposeCommentView;


// create delegate method to inform cell controller when image is tapped
@protocol MediaTableViewCellDelegate <NSObject>

- (void) cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;
- (void) cellDidPressLikeButton:(MediaTableViewCell *)cell;
- (void) cellWillStartComposingComment:(MediaTableViewCell *)cell;
- (void) cell:(MediaTableViewCell *)cell didComposeComment:(NSString *)comment;


@end

@interface MediaTableViewCell : UITableViewCell


//Each cell will be associated with a single media item. When we use this cell later in our ImagesTableViewController, we'll only have to update this one property to configure the cell for display.
@property (nonatomic, strong) Media *mediaItem;

@property (nonatomic, weak) id <MediaTableViewCellDelegate> delegate;
@property (nonatomic, strong, readonly) ComposeCommentView *commentView;
@property (nonatomic, strong) UITraitCollection *overrideTraitCollection;

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width traitCollection:(UITraitCollection *) traitCollection;

- (void) stopComposingComment;
- (Media *) updateCommentForMediaItem:(Media *)mediaItem forIndexPath:(NSIndexPath *)indexPath;


@end
