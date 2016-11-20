//
//  GZSMainViewController.m
//  SlackClient
//
//  Created by George Zinyakov on 11/19/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSMainViewController.h"
#import "GZSAccountService.h"
#import "GZSSegueNames.h"

@interface GZSMainViewController ()
@property (readwrite, strong, nonatomic) GZSAccountService *accountService;
@end

@implementation GZSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountService = [GZSAccountService new];
    [self setUpRootViewController];
}

- (void)setUpRootViewController {
    [[self.accountService testAuth] subscribeNext:^(id  _Nullable x) {
        [self performSegueWithIdentifier:kSegueFromMainToContent sender:nil];
    } error:^(NSError * _Nullable error) {
        NSLog(@"error : %@", error);
        // if error code is network error code
        if (error.code != 0) {
            [self performSegueWithIdentifier:kSegueFromMainToContent sender:nil];
        } else {
            [self performSegueWithIdentifier:kSegueFromMainToAuth sender:nil];
        }
    } completed:^{
    }];
}

@end
