//
//  GZSChannelService.m
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm_JSON/RLMObject+JSON.h>

#import "GZSChannelService.h"
#import "RLMResults+GZSlackClient.h"
#import "GZSApiClient.h"

@interface GZSChannelService ()
@property (readwrite, nonatomic, strong) GZSApiClient *apiClient;
@property (readwrite, nonatomic, strong) RLMRealm *storage;
@end

@implementation GZSChannelService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.apiClient = [GZSApiClient manager];
        self.storage = [RLMRealm defaultRealm];
    }
    return self;
}

#pragma mark - Get channels from local db

- (RLMResults * _Nonnull)allPublicChannels {
    return [GZSChannel objectsWhere:@"isChannel == YES"];
}

- (RLMResults * _Nonnull)allPrivateChannels {
    return [GZSChannel objectsWhere:@"isGroup == YES"];
}

- (RLMResults * _Nonnull)allMPIMs {
    return [GZSChannel objectsWhere:@"isMPIM == YES"];
}

- (RLMResults * _Nonnull)allIMs {
    return [GZSChannel objectsWhere:@"isIM == YES"];
}

#pragma mark - Delete channels from local db

- (RACSignal * _Nonnull)deleteChannelsWithResults:(RLMResults *)results {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.storage transactionWithBlock:^{
            [self.storage deleteObjects:results];
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (RACSignal * _Nonnull)deleteAllPublicChannels {
    return [self deleteChannelsWithResults:[self allPublicChannels]];
}

- (RACSignal * _Nonnull)deleteAllPrivateChannels {
    return [self deleteChannelsWithResults:[self allPrivateChannels]];
}

- (RACSignal * _Nonnull)deleteAllMPIMs {
    return [self deleteChannelsWithResults:[self allMPIMs]];
}

- (RACSignal * _Nonnull)deleteAllIMs {
    return [self deleteChannelsWithResults:[self allIMs]];
}

#pragma mark - Add channels to local db

- (RACSignal * _Nonnull)addOrUpdateChannelWithJSONDictionary:(NSDictionary * _Nonnull)dictionary {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.storage transactionWithBlock:^{
            GZSChannel *channel = [GZSChannel createOrUpdateInRealm:self.storage withJSONDictionary:dictionary];
            [subscriber sendNext:channel];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (RACSignal * _Nonnull)addOrUpdateChannelsWithJSONArray:(NSArray * _Nonnull)array {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.storage transactionWithBlock:^{
            NSArray *channels = [GZSChannel createOrUpdateInRealm:self.storage withJSONArray:array];
            [subscriber sendNext:channels];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

#pragma mark - API methods

- (RACSignal * _Nonnull)downloadAndAddChannelsWithMethod:(NSString *)methodName jsonKey:(NSString *)jsonKey {
    return [[self.apiClient
             GETAuthorizedRequestWithMethodName:methodName parameters:nil]
            flattenMap:^RACStream *(NSDictionary *responseJSON) {
                NSArray *jsonArray = responseJSON[jsonKey];
                return [self addOrUpdateChannelsWithJSONArray:jsonArray];
            }];
}

- (RACSignal * _Nonnull)downloadAllPublicChannels {
    return [self downloadAndAddChannelsWithMethod:@"channels.list" jsonKey:@"channels"];
}

- (RACSignal * _Nonnull)downloadAllPrivateChannels {
    return [self downloadAndAddChannelsWithMethod:@"groups.list" jsonKey:@"groups"];
}

- (RACSignal * _Nonnull)downloadAllMPIMs {
    return [self downloadAndAddChannelsWithMethod:@"mpim.list" jsonKey:@"groups"];
}

- (RACSignal * _Nonnull)downloadAllIMs {
    return [self downloadAndAddChannelsWithMethod:@"im.list" jsonKey:@"ims"];
}

@end
