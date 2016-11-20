//
//  GZSProfile.h
//  SlackClient
//
//  Created by George Zinyakov on 11/18/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm/Realm.h>

@interface GZSProfile : RLMObject
@property NSString *profileId;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *realName;
@property NSString *email;
@property NSString *skype;
@property NSString *phone;
@property NSString *image24;
@property NSString *image32;
@property NSString *image48;
@property NSString *image72;
@property NSString *image192;
@property NSString *image512;
@end
