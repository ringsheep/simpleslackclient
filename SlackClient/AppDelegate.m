//
//  AppDelegate.m
//  SlackClient
//
//  Created by George Zinyakov on 11/5/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (self.window) {
        UIStoryboard *authStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *rootViewController = [authStoryboard instantiateViewControllerWithIdentifier:@"rootMainController"];
        self.window.rootViewController = rootViewController;
    }
    return YES;
}

@end
