//
//  Oauth2Service.h
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "GZSAccount.h"

@interface GZSAccountService : NSObject
- (GZSAccount * _Nullable)currentAccount;
- (RACSignal * _Nonnull)addOrUpdateAccountWithJSONDictionary:(NSDictionary * _Nonnull)dictionary;
- (RACSignal * _Nonnull)testAuth;
- (NSURLRequest * _Nonnull)authorizationRequest;
- (RACSignal * _Nonnull)logInWithCode:(NSString * _Nonnull)code;
@end
