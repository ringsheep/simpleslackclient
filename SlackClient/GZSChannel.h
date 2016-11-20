//
//  GZSChannel.h
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm/Realm.h>
#import "GZSMemberId.h"
#import "GZSTopic.h"

RLM_ARRAY_TYPE(GZSMemberId)

@interface GZSChannel : RLMObject
@property NSString *channelId;
@property NSString *name;
@property NSDate *created;
@property NSString *creator;
@property NSString *user;
@property NSDate *lastRead;
@property NSInteger unreadCount;
@property NSInteger unreadCountDisplay;
@property RLMArray<GZSMemberId> *members;
@property GZSTopic *purpose;
@property GZSTopic *topic;
@property BOOL isArchived;
@property BOOL isGeneral;
@property BOOL isMember;
@property BOOL isChannel;
@property BOOL isGroup;
@property BOOL isMPIM;
@property BOOL isIM;
@property BOOL isUserDeleted;
@property BOOL isOpen;
@property BOOL hasPins;
@end
