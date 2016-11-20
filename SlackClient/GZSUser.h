//
//  GZSUser.h
//  SlackClient
//
//  Created by George Zinyakov on 11/9/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm/Realm.h>
#import "GZSProfile.h"

@interface GZSUser : RLMObject
@property NSString *userId;
@property NSString *teamId;
@property NSString *name;
@property BOOL deleted;
@property NSString *status;
@property NSString *color;
@property BOOL isAdmin;
@property BOOL isOwner;
@property BOOL isPrimaryOwner;
@property BOOL hasFiles;
@property GZSProfile *profile;
@end
