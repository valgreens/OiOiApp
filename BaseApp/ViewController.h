//
//  ViewController.h
//  BaseApp
//
//  Created by Ricardo Caballero Moral on 22/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSArray *myOis;
@property (strong, nonatomic) NSMutableArray *subscribed;
@property (strong, nonatomic) NSMutableArray *invited;

@end
