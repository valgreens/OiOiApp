//
//  ViewController.m
//  BaseApp
//
//  Created by Ricardo Caballero Moral on 22/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "ViewController.h"
#import "OiViewController.h"
#import "NewOiViewController.h"
#import "AVNetwork.h"
#import "Parse/Parse.h"

@interface ViewController ()
{
    AVNetwork *server;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"OiOi";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newOi:)];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:80/255.0 green:160/255.0 blue:174/255.0 alpha:1.0];
    
    server = [AVNetwork sharedNetwork];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *email = [prefs stringForKey:@"email"];
    NSString *deviceToken = [prefs stringForKey:@"deviceToken"];
    
    self.myOis = [server lisOfOisByUser: email];
    self.subscribed = [[NSMutableArray alloc] init];
    self.invited = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [self.myOis count]; i = i + 1) {
        
        NSUInteger index1 = [[[self.myOis objectAtIndex:i] objectForKey:@"subscribers"] indexOfObject:email];
        if (index1 != NSNotFound)
        {
            [self.subscribed insertObject:[self.myOis objectAtIndex:i] atIndex:0];
            // Tell Parse about the device token.
            [PFPush storeDeviceToken:deviceToken];
            [PFPush subscribeToChannelInBackground:[[self.myOis objectAtIndex:i] objectForKey:@"channel"]];
            continue;
        }
        NSUInteger index2 = [[[self.myOis objectAtIndex:i] objectForKey:@"invited"] indexOfObject:email];
        if (index2 != NSNotFound)
        {
            [self.invited insertObject:[self.myOis objectAtIndex:i] atIndex:0];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    NSInteger result = 2;
    return result;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    switch (section) {
        case 0:
            result = [self.subscribed count];
            break;
        case 1:
            result = [self.invited count];
            break;
    }
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *result = @"";
    switch (section) {
        case 0:
            result = @"My Ois!";
            break;
        case 1:
            result = @"Invited";
            break;
    }
    return result;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = nil;
    if ([tableView isEqual:self.table])
    {
        if (indexPath.section == 0)
        {
            NSString *TableViewCellIdentifier = [NSString stringWithFormat:@"%@", [[self.subscribed objectAtIndex:(int)indexPath.row] objectForKey: @"_id"]];
            result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
            if (result == nil)
            {
                result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
            }
            
            NSString *name = [[self.subscribed objectAtIndex:(int)indexPath.row] objectForKey: @"name"];
            result.textLabel.text = [NSString stringWithFormat:@"%@", name];
            result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.section == 1)
        {
            NSString *TableViewCellIdentifier = [NSString stringWithFormat:@"%@", [[self.invited objectAtIndex:(int)indexPath.row] objectForKey: @"_id"]];
            result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
            if (result == nil)
            {
                result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
            }
            
            NSString *name = [[self.invited objectAtIndex:(int)indexPath.row] objectForKey: @"name"];
            result.textLabel.text = [NSString stringWithFormat:@"%@", name];
            result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return result;
}

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *item = nil;
    switch (indexPath.section) {
        case 0:
            item = [self.subscribed objectAtIndex: [indexPath row]];
            break;
        case 1:
            item = [self.invited objectAtIndex: [indexPath row]];
            break;
    }
    
    [self pushSecondControllerWithData:item];
}

- (void) pushSecondControllerWithData: (NSDictionary *)data
{
    OiViewController *oiView = [[OiViewController alloc] initWithNibName:@"OiViewController" bundle:nil];
    [oiView passData: data];
    [self.navigationController pushViewController:oiView animated:YES];
}
                                                                                                 
- (void) newOi: (id) sender
{
    NewOiViewController *newOiView = [[NewOiViewController alloc] initWithNibName:@"NewOiViewController" bundle:nil];
    [self.navigationController pushViewController:newOiView animated:YES];
}

@end
