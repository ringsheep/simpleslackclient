//
//  GZSChannelCell.m
//  SlackClient
//
//  Created by George Zinyakov on 11/17/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSChannelCell.h"

@interface GZSChannelCell ()
@property (weak, nonatomic) IBOutlet UILabel *channelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelUnreadCount;
@property (weak, nonatomic) IBOutlet UILabel *channelLastMessage;
@end

@implementation GZSChannelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureSelfWithChannel:(GZSChannel * _Nonnull)channel {
    self.channelNameLabel.text = channel.name;
    if (channel.unreadCountDisplay == 0) {
        self.channelUnreadCount.text = @"";
    } else {
        self.channelUnreadCount.text = [NSString stringWithFormat:@"%d", channel.unreadCountDisplay];
    }
    self.channelLastMessage.text = @"";
}

- (void)configureSelfWithChannel:(GZSChannel * _Nonnull)channel user:(GZSUser * _Nonnull)user {
    self.channelNameLabel.text = user.name;
    if (channel.unreadCountDisplay == 0) {
        self.channelUnreadCount.text = @"";
    } else {
        self.channelUnreadCount.text = [NSString stringWithFormat:@"%d", channel.unreadCountDisplay];
    }
    self.channelLastMessage.text = @"";
}

@end
