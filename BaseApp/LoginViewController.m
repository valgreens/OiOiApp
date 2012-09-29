//
//  LoginViewController.m
//  BaseApp
//
//  Created by Antonio Valverde on 24/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "AVNetwork.h"

@interface LoginViewController ()
{
    AVNetwork *server;
}
@end

@implementation LoginViewController

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
    [self.loadingView setHidden:TRUE];
    server = [AVNetwork sharedNetwork];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) sendData: (id) sender
{

    [self.email resignFirstResponder];
    [self.pass resignFirstResponder];
    
    [self.loginButton setHidden:TRUE];
    [self.loadingView setHidden:FALSE];
        
    [self.loadingView startAnimating];
    
    // API call
    NSString *key = [server loginWithEmail:self.email.text password:self.pass.text];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:self.email.text forKey:@"email"];
    [prefs setObject:key forKey:@"login_key"];
    [prefs synchronize];
    
    NSLog(@"Creada login_key");
    NSLog(@"Key: %@", key);
    
    ViewController *vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction) nextField: (id) sender
{
    UITextField* nextField = self.pass;
    [nextField becomeFirstResponder];
}

@end
