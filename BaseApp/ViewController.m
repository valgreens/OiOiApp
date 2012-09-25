//
//  ViewController.m
//  BaseApp
//
//  Created by Ricardo Caballero Moral on 22/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "ViewController.h"
#import "RCServer.h"

@interface ViewController ()
{
    RCServer *server;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs stringForKey:@"login_key"] != nil)
    {
        NSLog(@"Existe la login key");
        NSLog(@"Key: %@", [prefs stringForKey:@"login_key"]);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) refresh: (id) sender
{
    
}

@end
