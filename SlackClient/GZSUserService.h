//
//  GZSUserService.h
//  SlackClient
//
//  Created by George Zinyakov on 11/7/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <Realm/Realm.h>

#import "GZSUser.h"

@interface GZSUserService : NSObject
- (RLMResults * _Nonnull)allUsers;
- (RACSignal * _Nonnull)downloadAllUsers;
@end
