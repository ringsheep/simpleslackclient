//
//  GZSApiClient.m
//  SlackClient
//
//  Created by George Zinyakov on 11/7/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSApiClient.h"

@interface GZSApiClient ()
@end

@implementation GZSApiClient

NSString *const slackURL = @"https://slack.com/api/";

+ (instancetype)manager {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [self initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:slackURL]]];
    if (self) {
        [self.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (RACSignal * _Nonnull)GETRequestWithMethodName:(NSString * _Nonnull)methodName parameters:(NSDictionary * _Nullable)parameters {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *fullUrl = [slackURL stringByAppendingString:methodName];
        [self GET:fullUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                NSLog(@"%@", task.originalRequest);
                NSLog(@"%@", responseObject);
                
                if (responseObject[@"ok"] == NO) {
                    NSString *errorMessage = responseObject[@"error"];
                    NSError *apiError = [[NSError alloc] initWithDomain:NSURLErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
                    [subscriber sendError:apiError];
                } else {
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                }
            } else {
                NSError *noResponseError = [[NSError alloc] initWithDomain:NSURLErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : @"Empty Response"}];
                [subscriber sendError:noResponseError];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            [subscriber sendError:error];
        }];
        return nil;
    }];
}

- (RACSignal * _Nonnull)GETAuthorizedRequestWithMethodName:(NSString * _Nonnull)methodName parameters:(NSMutableDictionary * _Nullable)parameters {
    NSString *token = @"";
    GZSAccount *account = [[GZSAccount allObjects] objectAtIndex:0];
    if (account) {
        token = account.accessToken;
    }
    if (parameters != nil) {
        parameters[@"token"] = token;
        return [self GETRequestWithMethodName:methodName parameters:parameters];
    } else {
        NSDictionary *newParameters = @{@"token" : token};
        return [self GETRequestWithMethodName:methodName parameters:newParameters];
    }
}

@end
