//
//  RLMResults+GZSlackClient.h
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <Realm/Realm.h>

@interface RLMResults<RLMObjectType: RLMObject *> (ToArray)

- (NSArray<RLMObjectType> *)toArray;
- (NSArray<RLMObjectType> *)toCopiesArray;

@end
