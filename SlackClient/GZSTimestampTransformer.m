//
//  GZSTimestampTransformer.m
//  SlackClient
//
//  Created by George Zinyakov on 11/18/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSTimestampTransformer.h"

@implementation GZSTimestampTransformer

+ (Class)transformedValueClass {
    return [NSDate class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(NSString *)value {
    return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
}

@end
