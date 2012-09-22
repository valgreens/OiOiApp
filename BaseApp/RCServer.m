//
//  RCServer.m
//  BaseApp
//
//  Created by Ricardo Caballero Moral on 22/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "RCServer.h"

@implementation RCServer

+ (RCServer *)sharedInstance {
    static RCServer *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[RCServer alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    if (self = [super init]) {
        // Init
        [self _init];
    }
    return self;
}

- (void)_init
{
    // Custom init method 
}

@end
