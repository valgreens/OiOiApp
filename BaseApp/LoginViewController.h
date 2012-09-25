//
//  LoginViewController.h
//  BaseApp
//
//  Created by Antonio Valverde on 24/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *pass;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;



@end
