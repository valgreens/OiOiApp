//
//  NewOiViewController.m
//  BaseApp
//
//  Created by Antonio Valverde on 01/10/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "NewOiViewController.h"

@interface NewOiViewController ()

@end

@implementation NewOiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"New Oi!";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:80/255.0 green:160/255.0 blue:174/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStyleBordered target:self action:@selector(createOi)];
    [self.contactsTable setEditing:YES animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    NSInteger result = 1;
    return result;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 1;
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Add Contacts";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = nil;
    if ([tableView isEqual:self.contactsTable])
    {
        NSString *TableViewCellIdentifier = [NSString stringWithFormat:@"Cell"];
        result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (result == nil)
        {
            result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
        }
        result.textLabel.text = @"Hola";
    }
    return result;
}

// Edicion


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger ct = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    if (ct-1 == indexPath.row)
        return UITableViewCellEditingStyleInsert;
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ct = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    NSArray *index = [[NSArray alloc] initWithObjects:0, ct, nil];
    if (indexPath.row == ct - 1){
        [tableView insertRowsAtIndexPaths:index withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)createOi
{
    NSLog(@"Oi Creado");
}

@end
