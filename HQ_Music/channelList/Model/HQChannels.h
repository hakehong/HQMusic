//
//  channels.h
//  HQ_Music
//
//  Created by hongqing on 16/1/5.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQChannels : NSObject
/** 电台频道的名称 */
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString *seq_id;
/** 电台频道号 */
@property (nonatomic,retain) NSNumber *channel_id;

@end
