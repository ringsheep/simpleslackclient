//
//  GZSProfile.m
//  SlackClient
//
//  Created by George Zinyakov on 11/18/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSProfile.h"

@implementation GZSProfile

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"first_name": @"firstName",
             @"last_name": @"lastName",
             @"real_name": @"realName",
             @"email": @"email",
             @"skype": @"skype",
             @"phone": @"phone",
             @"image_24": @"image24",
             @"image_32": @"image32",
             @"image_48": @"image48",
             @"image_72": @"image72",
             @"image_192": @"image192",
             @"image_512": @"image512",
             };
}

+ (NSString *)primaryKey {
    return @"profileId";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{
             @"firstName": @"",
             @"lastName": @"",
             @"realName": @"",
             @"email": @"",
             @"skype": @"",
             @"phone": @"",
             @"image24": @"",
             @"image32": @"",
             @"image48": @"",
             @"image72": @"",
             @"image192": @"",
             @"image512": @"",
             };
}

@end
