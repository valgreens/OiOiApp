//
//  OiViewController.m
//  BaseApp
//
//  Created by Antonio Valverde on 28/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "OiViewController.h"
#import "AVNetwork.h"

@interface OiViewController ()
{
    AVNetwork *server;
}
@end

@implementation OiViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.arrayOiHeaders = [[NSArray alloc] initWithObjects:@"Owner", @"Subscribers", @"Invited", nil];
        
    }
    return self;
}

- (void) passData: (NSDictionary *)data
{
    self.oiData = data;
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    server = [AVNetwork sharedNetwork];
    self.title = [NSString stringWithFormat:@"%@", [self.oiData objectForKey:@"name"]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStyleBordered target:self action:@selector(pushMessage)];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:80/255.0 green:160/255.0 blue:174/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    NSInteger result = [self.arrayOiHeaders count];
    return result;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    switch (section) {
        case 0:
            result = 1;
            break;
        case 1:
            result = [[self.oiData objectForKey:@"subscribers"] count];
            break;
        case 2:
            result = [[self.oiData objectForKey:@"invited"] count];
            break;
    }
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.arrayOiHeaders objectAtIndex:section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = nil;
    if ([tableView isEqual:self.table])
    {
        NSString *TableViewCellIdentifier = [NSString stringWithFormat:@"Cell"];
        result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (result == nil)
        {
            result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
        }
        
        switch (indexPath.section) {
            case 0:
                result.textLabel.text = [NSString stringWithFormat:@"%@", [self.oiData objectForKey:@"owner"]];
                break;
            case 1:
                result.textLabel.text = [NSString stringWithFormat:@"%@", [[self.oiData objectForKey:@"subscribers"] objectAtIndex:indexPath.row]];
                break;
            case 2:
                result.textLabel.text = [NSString stringWithFormat:@"%@", [[self.oiData objectForKey:@"invited"] objectAtIndex:indexPath.row]];
                break;
        }
        
        
    }
    return result;
}

- (void) pushMessage
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *key = [prefs stringForKey:@"login_key"];
    NSString *oi = [NSString stringWithFormat:@"%@", [self.oiData objectForKey:@"_id"]];
    BOOL result = [server pushToOi: oi withKey: key];
    
    if (result)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Oi!" message:@"Your push was awesome!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Oi!" message:@"Oops something went wrong!" delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil];
        [alert show];
    }
}


@end
