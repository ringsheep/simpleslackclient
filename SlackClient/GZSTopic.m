//
//  GZSTopic.m
//  SlackClient
//
//  Created by George Zinyakov on 11/18/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSTopic.h"
#import "RLMObject+JSON.h"
#import "GZSTimestampTransformer.h"

@implementation GZSTopic

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"creator": @"creator",
             @"last_set": @"lastSet",
             @"value": @"value",
             };
}

+ (NSString *)primaryKey {
    return @"topicId";
}

+ (NSValueTransformer *)lastSetJSONTransformer {
    return [GZSTimestampTransformer new];
}

+ (NSDictionary *)defaultPropertyValues {
    return @{
             @"topicId": [[NSUUID UUID] UUIDString],
             @"creator": @"",
             @"lastSet": [NSDate date],
             @"value": @"",
             };
}

@end
