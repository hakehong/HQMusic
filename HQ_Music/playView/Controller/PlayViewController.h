//
//  PlayViewController.h
//  HQ_Music
//
//  Created by hongqing on 15/12/23.
//  Copyright © 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "songList.h"
#import "ChannelListTableViewController.h"
@interface PlayViewController : UIViewController
@property(nonatomic, assign,getter=isPlaying) BOOL playing;
@end
