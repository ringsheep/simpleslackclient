//
//  RLMResults+GZSlackClient.m
//  SlackClient
//
//  Created by George Zinyakov on 11/15/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "RLMResults+GZSlackClient.h"
#import <Realm_JSON/RLMObject+Copying.h>

@implementation RLMResults (GZSlackClient)

- (NSArray *)toArray {
    NSMutableArray *array = [NSMutableArray new];
    for (RLMObject *object in self) {
        [array addObject:object];
    }
    return array;
}

- (NSArray *)toCopiesArray {
    NSMutableArray *array = [NSMutableArray new];
    for (RLMObject *object in self) {
        [array addObject:[object deepCopy]];
    }
    return array;
}

@end
