//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by Jason Owen on 2/23/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media, MediaTableViewCell;


// create delegate method to inform cell controller when image is tapped
@protocol MediaTableViewCellDelegate <NSObject>

- (void) cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;
- (void) cellDidPressLikeButton:(MediaTableViewCell *)cell;

@end

@interface MediaTableViewCell : UITableViewCell


//Each cell will be associated with a single media item. When we use this cell later in our ImagesTableViewController, we'll only have to update this one property to configure the cell for display.
@property (nonatomic, strong) Media *mediaItem;

@property (nonatomic, weak) id <MediaTableViewCellDelegate> delegate;



 + (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;
- (Media *) updateCommentForMediaItem:(Media *)mediaItem forIndexPath:(NSIndexPath *)indexPath;


@end
