//
//  AVNetwork.h
//  BaseApp
//
//  Created by Antonio Valverde on 26/09/12.
//  Copyright (c) 2012 Ricardo Caballero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVNetwork : NSObject

+ (AVNetwork *) sharedNetwork;


- (NSString *) loginWithEmail: (NSString *) email password: (NSString *) password;

- (NSArray *) listOfUsers;

- (NSArray *) listOfOis;

- (NSArray *) lisOfOisByUser: (NSString *)email;

- (NSDictionary *) createOiWithKey: (NSString *)key name: (NSString *)name contacts: (NSArray *)contacts;

- (id) subscribeToOi: (NSString *)oi withKey: (NSString *)key;

- (BOOL) pushToOi: (NSString *)oi withKey: (NSString *)key;

- (NSDictionary *)parseResponseWithData: (NSData *)data;

@end
