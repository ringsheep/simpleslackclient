//
//  GZSChannelCell.h
//  SlackClient
//
//  Created by George Zinyakov on 11/17/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZSChannel.h"
#import "GZSUser.h"

@interface GZSChannelCell : UITableViewCell
- (void)configureSelfWithChannel:(GZSChannel * _Nonnull)channel;
- (void)configureSelfWithChannel:(GZSChannel * _Nonnull)channel user:(GZSUser * _Nonnull)user;
@end
