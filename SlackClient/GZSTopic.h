//
//  GZSTopic.h
//  SlackClient
//
//  Created by George Zinyakov on 11/18/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm/Realm.h>

@interface GZSTopic : RLMObject
@property NSString *topicId;
@property NSString *creator;
@property NSDate *lastSet;
@property NSString *value;
@end
