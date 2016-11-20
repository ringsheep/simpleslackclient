//
//  GZSChannelService.h
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <Realm/Realm.h>

#import "GZSChannel.h"

@interface GZSChannelService : NSObject

- (RLMResults * _Nonnull)allPublicChannels;
- (RLMResults * _Nonnull)allPrivateChannels;
- (RLMResults * _Nonnull)allMPIMs;
- (RLMResults * _Nonnull)allIMs;

- (RACSignal * _Nonnull)deleteAllPublicChannels;
- (RACSignal * _Nonnull)deleteAllPrivateChannels;
- (RACSignal * _Nonnull)deleteAllMPIMs;
- (RACSignal * _Nonnull)deleteAllIMs;

- (RACSignal * _Nonnull)addOrUpdateChannelWithJSONDictionary:(NSDictionary * _Nonnull)dictionary;
- (RACSignal * _Nonnull)addOrUpdateChannelsWithJSONArray:(NSArray * _Nonnull)array;

- (RACSignal * _Nonnull)downloadAllPublicChannels;
- (RACSignal * _Nonnull)downloadAllPrivateChannels;
- (RACSignal * _Nonnull)downloadAllMPIMs;
- (RACSignal * _Nonnull)downloadAllIMs;

@end
