//
//  NewOiViewController.h
//  BaseApp
//
//  Created by Antonio Valverde on 01/10/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewOiViewController : UIViewController <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *contactsTable;
@property (strong, nonatomic) IBOutlet UITextField *nameField;


@end
