//
//  GZSApiClient.h
//  SlackClient
//
//  Created by George Zinyakov on 11/7/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "GZSAccountService.h"

@interface GZSApiClient : AFHTTPSessionManager
- (RACSignal * _Nonnull)GETAuthorizedRequestWithMethodName:(NSString * _Nonnull)methodName parameters:(NSMutableDictionary * _Nullable)parameters;
- (RACSignal * _Nonnull)GETRequestWithMethodName:(NSString * _Nonnull)methodName parameters:(NSDictionary * _Nullable)parameters;
@end
