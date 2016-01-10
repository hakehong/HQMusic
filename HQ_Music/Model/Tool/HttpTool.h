//
//  HttpTool.h
//  HQ_Music
//
//  Created by hongqing on 16/1/6.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+(NSArray *)getChannelList:(NSArray *)channelList;
//+(void)getSongsInfo:(NSArray *)channelList pathRow:(NSString *)row
@end
