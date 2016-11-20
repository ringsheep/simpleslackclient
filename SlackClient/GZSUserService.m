//
//  GZSUserService.m
//  SlackClient
//
//  Created by George Zinyakov on 11/7/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSUserService.h"
#import "GZSApiClient.h"
#import "RLMObject+JSON.h"

@interface GZSUserService ()
@property (readwrite, nonatomic, strong) GZSApiClient *apiClient;
@property (readwrite, nonatomic, strong) RLMRealm *storage;
@end

@implementation GZSUserService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.apiClient = [GZSApiClient manager];
        self.storage = [RLMRealm defaultRealm];
    }
    return self;
}

- (RLMResults * _Nonnull)allUsers {
    return [GZSUser allObjects];
}

- (RACSignal * _Nonnull)addOrUpdateUsersWithJSONArray:(NSArray * _Nonnull)array {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.storage transactionWithBlock:^{
            NSArray *users = [GZSUser createOrUpdateInRealm:self.storage withJSONArray:array];
            [subscriber sendNext:users];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

#pragma mark - API methods

- (RACSignal * _Nonnull)downloadAllUsers {
    return [[self.apiClient
             GETAuthorizedRequestWithMethodName:@"users.list" parameters:nil]
            flattenMap:^RACStream *(NSDictionary *responseJSON) {
                NSArray *jsonArray = responseJSON[@"members"];
                return [self addOrUpdateUsersWithJSONArray:jsonArray];
            }];
}

@end
