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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createOi
{
    NSLog(@"Oi Creado");
}

@end
