//
//  LoginViewController.m
//  BaseApp
//
//  Created by Antonio Valverde on 24/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) sendData: (id) sender
{
    
    NSLog(@"Username: %@", [[NSString alloc] initWithString: self.email.text]);
    NSLog(@"Password: %@", [[NSString alloc] initWithString: self.pass.text]);
    
    NSString *e = self.email.text;
    NSString *p = self.pass.text;
    
    [self.email resignFirstResponder];
    [self.pass resignFirstResponder];
    
    [self.loginButton setHidden:TRUE];
    [self.loadingView setHidden:FALSE];
        
    [self.loadingView startAnimating];
    
    // API call
    NSString *s = @"https://api.blibb.net/users/login";
    NSURL *url = [NSURL URLWithString:s];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
        
    NSMutableString* body = [NSMutableString stringWithString: @"email="];
    [body appendString: e];
    [body appendString:@"&password="];
    [body appendString: p];

    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] >0 && error == nil)
        {
            // API Call Success
            // JSON Deserialization
            error = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (jsonObject != nil && error == nil)
            {
                NSLog(@"Successfully deserialized...");
                if ([jsonObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
                    NSLog(@"Deserialized JSON Dictionary = %@", deserializedDictionary);
                    NSLog(@"Key: %@", [deserializedDictionary objectForKey:@"key"]);
                    
                    // Saving login key
                    NSString *key = [deserializedDictionary objectForKey:@"key"];
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setObject:key forKey:@"login_key"];
                    [prefs synchronize];
                    
                    // Send to App Main View
                    ViewController *vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
                    [self presentViewController:vc animated:YES completion:nil];
                    
                }
                else if ([jsonObject isKindOfClass:[NSArray class]])
                {
                    NSArray *deserializedArray = (NSArray *)jsonObject;
                    NSLog(@"Deserialized JSON Array = %@", deserializedArray);
                }
            }
        }
        else if ([data length] == 0 && error == nil)
        {
            NSLog(@"Nothing was downloaded.");
        }
        else if (error != nil)
        {
            NSLog(@"Error happened = %@", error);
        }
    }];
    
}

- (IBAction) nextField: (id) sender
{
    UITextField* nextField = self.pass;
    [nextField becomeFirstResponder];
}

@end
