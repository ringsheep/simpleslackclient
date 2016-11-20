//
//  GZSTeam.h
//  SlackClient
//
//  Created by George Zinyakov on 11/9/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm/Realm.h>

@interface GZSTeam : RLMObject
@property NSString *teamId;
@property NSString *teamName;
@end
