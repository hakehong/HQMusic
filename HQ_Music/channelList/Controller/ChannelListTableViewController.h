//
//  ChannelListTableViewController.h
//  HQ_Music
//
//  Created by hongqing on 15/12/23.
//  Copyright © 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PassSongsInfoDelegate
@required
-(void)PassSongsInfo:(NSString *)url picture:(NSString *)picture artist:(NSString *)artist;

@end
@interface ChannelListTableViewController : UITableViewController
//@property (strong,nonatomic) id <PassSongsInfoDelegate> passDelegate;
@end
