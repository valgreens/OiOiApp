//
//  RCServer.m
//  BaseApp
//
//  Created by Ricardo Caballero Moral on 22/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "RCServer.h"
#import "AFJSONRequestOperation.h"

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

#pragma mark - Request

- (void)request
{
    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/public_timeline.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

@end

