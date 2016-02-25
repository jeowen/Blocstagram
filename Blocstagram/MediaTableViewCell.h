//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by Jason Owen on 2/23/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;
@interface MediaTableViewCell : UITableViewCell


//Each cell will be associated with a single media item. When we use this cell later in our ImagesTableViewController, we'll only have to update this one property to configure the cell for display.
@property (nonatomic, strong) Media *mediaItem;

 + (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;
- (Media *) updateCommentForMediaItem:(Media *)mediaItem forIndexPath:(NSIndexPath *)indexPath;


@end
