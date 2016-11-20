//
//  GZSMemberId.m
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSMemberId.h"

@implementation GZSMemberId

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{@"self": @"value",};
}

+ (NSString *)primaryKey {
    return @"value";
}

@end
