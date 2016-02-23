//
//  ImagesTableViewController.m
//  Blocstagram
//
//  Created by Jason Owen on 2/19/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "DataSource.h"
#import "Media.h"
#import "User.h"
#import "Comment.h"


@interface ImagesTableViewController ()

@end



@implementation ImagesTableViewController


// Override the table view controller's initializer to create an empty array:
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        // self.images = [NSMutableArray array];
        
    }
    return self;
}
//-------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //populate self.images array with objects added to images folder
//    for (int i = 1; i <= 10; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
//        UIImage *image = [UIImage imageNamed:imageName];
//        if (image) {
//            [self.images addObject:image];
//        }
//    }// end for
    
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    // SECTIONS break the table view into different, well, SECTIONS
//    // since UITableView defaults to 1, we will COMMENT OUT THIS METHOD
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [DataSource sharedInstance].mediaItems.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
    UIImage *image = item.image;
    return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // #1
    //In #1, dequeueReusableCellWithIdentifier:forIndexPath: takes the identifier string and compares it with its roster of registered table view cells. Remember, we registered the UITableViewCell class in viewDidLoad with the identifier imageCell.
//    
//    Dequeue will either return:
//    
//    a brand new cell of the type we registered, or
//    a used one that is no longer visible on screen.
//    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    // Configure the cell...
    // #2
    // In #2, we set imageViewTag to an arbitrary number - what matters is that it remains consistent. A numerical tag can be attached to any UIView and used later to recover it from its superview by invoking viewWithTag:. This is a quick and dirty way for us to recover the UIImageView which will host the image for this cell.
    
    static NSInteger imageViewTag = 1234;
    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:imageViewTag];
    
    // #3
    //In #3, we handle the case when viewWithTag: fails to recover a UIImageView. That means it didn't have one and therefore it's a brand new cell. We know it's a new cell because we plan to add a UIImageView to each cell we come across. Therefore, on the second time around, it should already be there.
    
    if (!imageView) {
        // This is a new cell, it doesn't have an image view yet
        //We proceed to allocate a new UIImageView object. Its contentMode is specified as UIViewContentModeScaleToFill, which means the image will be stretched both horizontally and vertically to fill the bounds of the UIImageView. Then we set its frame to be the same as the UITableViewCell's contentView such that the image consumes the entirety of the cell.
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        

        // In #4, we set the image view's auto-resizing property. The autoresizingMask is associated with all UIView objects. This property lets its superview know how to resize it when the superview's width or height changes. These are called "bit-wise flags" and we set by OR-ing them together using |. The available options are as follows:
        imageView.frame = cell.contentView.bounds;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        imageView.tag = imageViewTag;
        [cell.contentView addSubview:imageView];
    }
    
    Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
    imageView.image = item.image;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        // remove image from self.images
        //[self.images removeObjectAtIndex:indexPath.row];
        
        [[DataSource sharedInstance] deleteRow:indexPath];
        
 
       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"\n**\n\n** delete row of table array here \n");

        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
