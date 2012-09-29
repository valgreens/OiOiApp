//
//  AppDelegate.h
//  BaseApp
//
//  Created by Ricardo Caballero Moral on 22/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class LoginViewController;
@class OiViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) OiViewController *oiViewController;

@end
