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
#import "MediaTableViewCell.h"


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
    
    // register for key-value observing from DataSource.m
    [[DataSource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    
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
    
    // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    [self.tableView registerClass:[MediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
}

// Key-Value observer MUST BE REMOVED when no longer needed
//dealloc is an NSObject method. It allows an object to perform some cleanup before the object goes away. This method is a class's last chance to do anything before self disappears.
// not removing an observer can cause a crash if the observed object attempts to communicate with an observing object that no longer exists
- (void) dealloc
{
    [[DataSource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}

#pragma mark METHOD to handle KEY-VALUE OBSERVATIONS
//By overriding this method, we can handle KVO updates.
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //The first thing we do is create an if statement which checks two things: 1)Is this update coming from the DataSource object we registered with?
    // 2) Is mediaItems the updated key?
    
    if (object == [DataSource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        // inside this IF block, we are certain we've received an update we care about
        // We know mediaItems changed.  Let's see what kind of change it is.
        
        //---------------------------->
        NSKeyValueChange kindOfChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            // Someone set a brand new images array
            [self.tableView reloadData];
        }
        else if (kindOfChange == NSKeyValueChangeInsertion ||
                 kindOfChange == NSKeyValueChangeRemoval ||
                 kindOfChange == NSKeyValueChangeReplacement) {
            // We have an incremental change: inserted, deleted, or replaced images
            
            // Get a list of the index (or indices) that changed
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            // #1 - Convert this NSIndexSet to an NSArray of NSIndexPaths (which is what the table view animation methods require)
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            // #2 - Call `beginUpdates` to tell the table view we're about to make changes
            [self.tableView beginUpdates];
            
            // Tell the table view what the changes are
            if (kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // Tell the table view that we're done telling it about changes, and to complete the animation
            [self.tableView endUpdates];
        }
    
        //--------------------------->
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
        
        // for checkpoint, move media item to top instead of deleting
        //[[DataSource sharedInstance] deleteMediaItem:item];
        [[DataSource sharedInstance] moveMediaItemToTop:item];
    }
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

    return [self items].count;
}

#pragma mark create items array for ease of formatting
- (NSMutableArray *) items{
    NSMutableArray *mediaItemArray = [[NSMutableArray alloc] init];
    mediaItemArray = [DataSource sharedInstance].mediaItems;
    return mediaItemArray;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Media *item = [self items][indexPath.row];
    return [MediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
    //return [MediaTableViewCell heightForMediaItem:item width:100];
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
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    // Configure the cell...
    // #2
    // In #2, we set imageViewTag to an arbitrary number - what matters is that it remains consistent. A numerical tag can be attached to any UIView and used later to recover it from its superview by invoking viewWithTag:. This is a quick and dirty way for us to recover the UIImageView which will host the image for this cell.
    
    
    
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.mediaItem = [DataSource sharedInstance].mediaItems[indexPath.row];
    
    MediaTableViewCell *cellToReturn = cell;
//    
//    // attempt to change color of comment to orange
    MediaTableViewCell *cellWithOrangeComment = cell;
//    
    
    //if indexPath = 0, cell to reutrn = cell with orange comment!
    if (indexPath.row == 0){
        //change color of comment to orange
        NSLog(@"******ImagesTableViewController detects the first ROW\n");
        cellWithOrangeComment.mediaItem =  [cellWithOrangeComment updateCommentForMediaItem:[DataSource sharedInstance].mediaItems[indexPath.row] forIndexPath:indexPath ];

    }
    return cellToReturn;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        // remove image from self.images
//        //[self.images removeObjectAtIndex:indexPath.row];
//        
//        [[DataSource sharedInstance] deleteRow:indexPath];
//        
// 
//       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        NSLog(@"\n**\n\n** delete row of table array here \n");
//
//        
//        
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


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
