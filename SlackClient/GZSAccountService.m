//
//  GZSOauth2Service.m
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm/Realm.h>
#import <Realm_JSON/RLMObject+JSON.h>

#import "GZSAccountService.h"
#import "GZSApiClient.h"
#import "GZSPrivateKeys.h"

@interface GZSAccountService ()
@property (readwrite, nonatomic, strong) GZSApiClient *apiClient;
@property (readwrite, nonatomic, strong) RLMRealm *storage;
@end

@implementation GZSAccountService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.apiClient = [GZSApiClient manager];
        self.storage = [RLMRealm defaultRealm];
    }
    return self;
}

- (GZSAccount * _Nullable)currentAccount {
    RLMResults *allAccounts = [GZSAccount allObjects];
    if (allAccounts.count > 0) {
        return [allAccounts objectAtIndex:0];
    }
    return nil;
}

- (RACSignal * _Nonnull)addOrUpdateAccountWithJSONDictionary:(NSDictionary * _Nonnull)dictionary {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.storage transactionWithBlock:^{
            GZSAccount *account = [GZSAccount createOrUpdateInRealm:self.storage withJSONDictionary:dictionary];
            [subscriber sendNext:account];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (RACSignal * _Nonnull)testAuth {
    NSString *methodName = @"auth.test";
    GZSAccount *account = [self currentAccount];
    if (account) {
        return [[self.apiClient GETAuthorizedRequestWithMethodName:methodName parameters:nil] flattenMap:^id(id responseObject) {
            NSString *correctUserId = responseObject[@"user_id"];
            NSString *correctTeamId = responseObject[@"team_id"];
            if ([account.userId isEqualToString:correctUserId] &&
                [account.teamId isEqualToString:correctTeamId]) {
                return [self addOrUpdateAccountWithJSONDictionary:responseObject];
            }
            NSString *errorMessage = @"Incorrect user or team";
            NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
            return [RACSignal error:error];
        }];
    }
    NSString *errorMessage = @"No user in local db";
    NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    return [RACSignal error:error];
}

- (NSURLRequest * _Nonnull)authorizationRequest {
    NSArray *scope = @[@"channels:read", @"channels:write", @"channels:history",
                       @"groups:read", @"groups:write", @"groups:history",
                       @"mpim:read", @"mpim:write", @"mpim:history",
                       @"im:read", @"im:write", @"im:history",
                       @"users:read"];
    NSString *scopeString = [scope componentsJoinedByString:@","];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://slack.com/oauth/authorize?client_id=%@&scope=%@", kClientId, scopeString];
    NSURL *authorizationURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:authorizationURL];
    return request;
}

- (RACSignal * _Nonnull)logInWithCode:(NSString * _Nonnull)code {
    NSString *methodName = @"oauth.access";
    NSDictionary *parameters = @{@"client_id" : kClientId, @"client_secret" : kClientSecret, @"code" : code};
    return [[self.apiClient GETRequestWithMethodName:methodName parameters:parameters]
            flattenMap:^RACStream *(id responseJSON) {
                return  [self addOrUpdateAccountWithJSONDictionary:responseJSON];
            }];
}

@end
