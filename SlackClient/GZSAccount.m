//
//  GZSAccount.m
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSAccount.h"

@implementation GZSAccount

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"user_id": @"userId",
             @"access_token": @"accessToken",
             @"team_id": @"teamId",
             @"team_name": @"teamName",
             };
}

+ (NSDictionary *)JSONOutboundMappingDictionary {
    return @{
             @"userId": @"user_id",
             @"accessToken": @"access_token",
             @"teamId": @"team_id",
             @"teamName": @"team_name",
             };
}

+ (NSString *)primaryKey {
    return @"accessToken";
}

@end
