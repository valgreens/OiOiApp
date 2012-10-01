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
    
    self.myOis = [server lisOfOisByUser: email];
    
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
    NSInteger result = [self.myOis count];
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"My Ois";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = nil;
    if ([tableView isEqual:self.table])
    {
        NSString *TableViewCellIdentifier = [NSString stringWithFormat:@"%@", [[self.myOis objectAtIndex:(int)indexPath.row] objectForKey: @"_id"]];
        result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (result == nil)
        {
            result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
        }
        
        NSString *name = [[self.myOis objectAtIndex:(int)indexPath.row] objectForKey: @"name"];
        result.textLabel.text = [NSString stringWithFormat:@"%@", name];
        result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return result;
}

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.myOis objectAtIndex: [indexPath row]];
    //OiViewController *oiView = [[OiViewController alloc] initWithNibName:@"OiViewController" bundle:nil];
    
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
