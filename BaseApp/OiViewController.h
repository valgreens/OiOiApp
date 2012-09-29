//
//  OiViewController.h
//  BaseApp
//
//  Created by Antonio Valverde on 28/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OiViewController : UIViewController <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *pushButton;
@property (strong, nonatomic) NSDictionary *oiData;
@property (strong, nonatomic) NSArray *arrayOiHeaders;

- (void) passData: (NSDictionary *)data;

@end
