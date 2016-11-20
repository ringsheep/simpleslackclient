//
//  GZSAccount.h
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm/Realm.h>
#import "GZSScope.h"

RLM_ARRAY_TYPE(GZSScope)

@interface GZSAccount : RLMObject
@property NSString *userId;
@property NSString *accessToken;
@property NSString *teamId;
@property NSString *teamName;
@property RLMArray<GZSScope> *scope;
@end
