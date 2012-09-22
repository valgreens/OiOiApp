//
//  RCServer.h
//  BaseApp
//
//  Created by Ricardo Caballero Moral on 22/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCServer : NSObject

+ (RCServer *) sharedInstance;

- (void)request;

@end
