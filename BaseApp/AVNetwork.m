//
//  AVNetwork.m
//  BaseApp
//
//  Created by Antonio Valverde on 26/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import "AVNetwork.h"

@implementation AVNetwork

+ (AVNetwork *) sharedNetwork
{
    static AVNetwork *_sharedNetwork = nil;
    
    if (nil == _sharedNetwork) {
        _sharedNetwork = [[AVNetwork alloc] init];
    }
    
    return _sharedNetwork;
}

- (id)init
{
    if (self = [super init])
    {
        // Init
        [self _init];
    }
    return self;
}

- (void)_init
{
    // Custom init method
}

- (NSString *) loginWithEmail: (NSString *) email password: (NSString *) password
{
    NSString *s = @"http://api.blibb.net/users/login";
    NSURL *url = [NSURL URLWithString:s];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSDictionary *json = [self parseResponseWithData:data];
    
    return [[NSString alloc] initWithString:[json objectForKey:@"key"]];
    
}

- (NSArray *) listOfUsers
{
    NSString *s = @"http://api.blibb.net/users?fields=email,created_at,roles,devices,password,salt,key,hotdog";
    NSURL *url = [NSURL URLWithString:s];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSDictionary *json = [self parseResponseWithData:data];
    NSArray *array = [json objectForKey:@"resultset"];
    return array;
}

- (NSArray *) listOfOis
{
    NSString *s = @"http://api.blibb.net/ois?fields=name,channel,owner,senders,subscribers,invited,created_at";
    NSURL *url = [NSURL URLWithString:s];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSDictionary *json = [self parseResponseWithData:data];
    NSArray *array = [json objectForKey:@"resultset"];

    return array;
}

- (NSArray *) lisOfOisByUser: (NSString *)email
{
    NSString *s = [NSString stringWithFormat:@"http://api.blibb.net/ois/%@?fields=channel,owner,senders,subscribers,invited,created_at", email];
    NSURL *url = [NSURL URLWithString:s];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSDictionary *json = [self parseResponseWithData:data];
    NSArray *array = [json objectForKey:@"resultset"];
    return array;
}

- (NSDictionary *) createOiWithKey: (NSString *)key name: (NSString *)name contacts: (NSArray *)contacts
{
    NSString *s = @"http://api.blibb.net/ois";
    NSURL *url = [NSURL URLWithString:s];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"login_key=%@&name=%@&contacts=%@", key, name, [contacts componentsJoinedByString:@","]];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSDictionary *json = [self parseResponseWithData:data];
    
    return json;
}

- (id) subscribeToOi: (NSString *)oi withKey: (NSString *)key
{
    NSString *s = [NSString stringWithFormat:@"http://api.blibb.net/ois/%@/subscribe", oi];
    NSURL *url = [NSURL URLWithString:s];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"login_key=%@", key];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSDictionary *json = [self parseResponseWithData:data];
    
    return json;
}

- (BOOL) pushToOi: (NSString *)oi withKey: (NSString *)key
{
    NSString *s = [NSString stringWithFormat:@"http://api.blibb.net/ois/%@/push", oi];
    NSURL *url = [NSURL URLWithString:s];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"login_key=%@", key];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSDictionary *json = [self parseResponseWithData:data];
    
    BOOL result = [[json objectForKey:@"push"] objectForKey:@"result"];
    
    if (result)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

- (NSDictionary *)parseResponseWithData: (NSData *)data
{
    NSError *error = nil;
    NSDictionary *deserializedDictionary = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil)
    {
        if ([jsonObject isKindOfClass:[NSDictionary class]])
        {
            deserializedDictionary = (NSDictionary *)jsonObject;
        }
    }
    return deserializedDictionary;
}

@end
