//
//  GZSChannel.m
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSChannel.h"
#import "RLMObject+JSON.h"
#import "GZSTimestampTransformer.h"

@implementation GZSChannel

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"id": @"channelId",
             @"name": @"name",
             @"user": @"user",
             @"creator": @"creator",
             @"created": @"created",
             @"unread_count": @"unreadCount",
             @"unread_count_display": @"unreadCountDisplay",
             @"members": @"members",
             @"purpose": @"purpose",
             @"topic": @"topic",
             @"is_member": @"isMember",
             @"is_group": @"isGroup",
             @"is_archived": @"isArchived",
             @"is_mpim": @"isMPIM",
             @"is_im": @"isIM",
             @"is_channel": @"isChannel",
             @"is_general": @"isGeneral",
             @"is_user_deleted": @"isUserDeleted",
             @"is_open": @"isOpen",
             @"has_pins": @"hasPins",
             };
}

+ (NSString *)primaryKey {
    return @"channelId";
}

+ (NSValueTransformer *)createdJSONTransformer {
    return [GZSTimestampTransformer new];
}

+ (NSDictionary *)defaultPropertyValues {
    return @{
             @"channelId": @0,
             @"name": @"",
             @"user": @"",
             @"creator": @"",
             @"created": [NSDate date],
             @"unreadCount": @0,
             @"unreadCountDisplay": @0,
             @"members": [[RLMArray alloc] initWithObjectClassName:@"GZSMemberId"],
             @"purpose": [GZSTopic new],
             @"topic": [GZSTopic new],
             @"isMember": @NO,
             @"isGroup": @NO,
             @"isArchived": @NO,
             @"isMPIM": @NO,
             @"isIM": @NO,
             @"isChannel": @NO,
             @"isGeneral": @NO,
             @"isUserDeleted": @NO,
             @"isOpen": @NO,
             @"hasPins": @NO,
             };
}

@end
