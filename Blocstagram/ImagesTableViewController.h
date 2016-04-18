//
//  ImagesTableViewController.h
//  Blocstagram
//
//  Created by Jason Owen on 2/19/16.
//  Copyright © 2016 Jason Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"

@interface ImagesTableViewController : UITableViewController

// create array to store the images that will be displayed in TableView
@property (nonatomic, strong) NSMutableArray *images;

@end
