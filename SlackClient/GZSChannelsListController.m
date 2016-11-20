//
//  GZSChannelsListController.m
//  SlackClient
//
//  Created by George Zinyakov on 11/17/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import <Realm/Realm.h>

#import "RLMResults+GZSlackClient.h"
#import "GZSChannelsListController.h"
#import "GZSChannelService.h"
#import "GZSAccountService.h"
#import "GZSUserService.h"
#import "GZSChannelCell.h"

@interface GZSChannelsListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, strong, nonatomic) GZSChannelService *channelService;
@property (readwrite, strong, nonatomic) GZSAccountService *accountService;
@property (readwrite, strong, nonatomic) GZSUserService *userService;

@property (readwrite, strong, nonatomic) NSArray *users;
@property (readwrite, strong, nonatomic) NSArray *publicChannels;
@property (readwrite, strong, nonatomic) NSArray *privateChannels;
@property (readwrite, strong, nonatomic) NSArray *MPIMChannels;
@property (readwrite, strong, nonatomic) NSArray *IMChannels;
@end

@implementation GZSChannelsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.channelService = [GZSChannelService new];
    self.accountService = [GZSAccountService new];
    self.userService = [GZSUserService new];
    
    NSString *teamName = [self.accountService currentAccount].teamName;
    self.title = teamName;
    
    [self downloadDataToTableView];
}

- (void)downloadDataToTableView {
    [[[self downloadAllUsers] concat:[self downloadAllChannels]]
     subscribeNext:^(id  _Nullable value) {
         NSString *key = [[value allKeys] objectAtIndex:0];
         if ([key isEqualToString:@"users"]) {
             self.users = value[key];
         }
         if ([key isEqualToString:@"publicChannels"]) {
             self.publicChannels = value[key];
             [self.tableView reloadData];
         }
         if ([key isEqualToString:@"privateChannels"]) {
             self.privateChannels = value[key];
             [self.tableView reloadData];
         }
         if ([key isEqualToString:@"MPIMChannels"]) {
             self.MPIMChannels = value[key];
             [self.tableView reloadData];
         }
         if ([key isEqualToString:@"IMChannels"]) {
             self.IMChannels = value[key];
             [self.tableView reloadData];
         }
     } error:^(NSError * _Nullable error) {
         NSLog(@"err - %@", error);
     } completed:^{
         NSLog(@"all channels downloaded");
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *channels = [self channelsAtSectionIndex:section];
    return channels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Public Channels";
            break;
        case 1:
            return @"Private Channels";
            break;
        case 2:
            return @"Multiuser instant messages";
            break;
        case 3:
            return @"Instant messages";
            break;
        default:
            return @"";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GZSChannelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"GZSChannelCell"];
    
    GZSChannel *channel = [[self channelsAtSectionIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (channel.isIM) {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"userId == %@", channel.user];
        NSArray *filteredUsers = [self.users filteredArrayUsingPredicate:filterPredicate];
        GZSUser *foundUser = [GZSUser new];
        if (filteredUsers.count > 0) {
            foundUser = [filteredUsers objectAtIndex:0];
        }
        [cell configureSelfWithChannel:channel user:foundUser];
        return cell;
    }
    [cell configureSelfWithChannel:channel];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Data tasks

- (NSArray * _Nonnull)channelsAtSectionIndex:(int)index {
    switch (index) {
        case 0:
            return self.publicChannels;
            break;
        case 1:
            return self.privateChannels;
            break;
        case 2:
            return self.MPIMChannels;
            break;
        case 3:
            return self.IMChannels;
            break;
        default:
            return [NSArray new];
            break;
    }
}

- (RACSignal * _Nonnull)downloadAllUsers {
    return [[self.userService downloadAllUsers] map:^id(id value) {
        NSArray *newUsers = [[self.userService allUsers] toCopiesArray];
        NSDictionary *newUsersSignal = @{@"users" : newUsers};
        return newUsersSignal;
    }];
}

- (RACSignal * _Nonnull)downloadAllChannels {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[[[self.channelService downloadAllPublicChannels]
            flattenMap:^RACStream *(id value) {
                NSArray *newPublicChannels = [[self.channelService allPublicChannels] toCopiesArray];
                NSDictionary *newChannelsSignal = @{@"publicChannels" : newPublicChannels};
                [subscriber sendNext:newChannelsSignal];
                
                return [self.channelService downloadAllPrivateChannels];
            }]
           flattenMap:^RACStream *(id value) {
               NSArray *newPrivateChannels = [[self.channelService allPrivateChannels] toCopiesArray];
               NSDictionary *newChannelsSignal = @{@"privateChannels" : newPrivateChannels};
               [subscriber sendNext:newChannelsSignal];
               
               return [self.channelService downloadAllMPIMs];
           }]
          flattenMap:^RACStream *(id value) {
              NSArray *newMPIMChannels = [[self.channelService allMPIMs] toCopiesArray];
              NSDictionary *newChannelsSignal = @{@"MPIMChannels" : newMPIMChannels};
              [subscriber sendNext:newChannelsSignal];
              
              return [self.channelService downloadAllIMs];
          }]
         subscribeNext:^(id  _Nullable x) {
             NSArray *newIMChannels = [[self.channelService allIMs] toCopiesArray];
             NSDictionary *newChannelsSignal = @{@"IMChannels" : newIMChannels};
             [subscriber sendNext:newChannelsSignal];
         } error:^(NSError * _Nullable error) {
             [subscriber sendError:error];
         } completed:^{
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}

@end
