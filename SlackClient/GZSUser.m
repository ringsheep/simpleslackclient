//
//  GZSUser.m
//  SlackClient
//
//  Created by George Zinyakov on 11/9/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSUser.h"

@implementation GZSUser

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"id": @"userId",
             @"name": @"name",
             @"team_id": @"teamId",
             @"deleted": @"deleted",
             @"status": @"status",
             @"color": @"color",
             @"is_admin": @"isAdmin",
             @"is_owner": @"isOwner",
             @"is_primary_owner": @"isPrimaryOwner",
             @"has_files": @"hasFiles",
             @"profile": @"profile",
             };
}

+ (NSString *)primaryKey {
    return @"userId";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{
             @"userId": @"",
             @"name": @"Unknown user",
             @"teamId": @"",
             @"deleted": @NO,
             @"status": @"",
             @"color": @"ffffff",
             @"isAdmin": @NO,
             @"isOwner": @NO,
             @"isPrimaryOwner": @NO,
             @"hasFiles": @NO,
             @"profile": [GZSProfile new],
             };
}

@end
