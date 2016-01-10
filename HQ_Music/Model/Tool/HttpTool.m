//
//  HttpTool.m
//  HQ_Music
//
//  Created by hongqing on 16/1/6.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "HttpTool.h"
#import "HQChannels.h"
#import "MJExtension.h"
#import "songList.h"
@implementation HttpTool
+(NSArray *)getChannelList:(NSArray *)channelList
{
    NSURL *url =[NSURL URLWithString:@"http://www.douban.com/j/app/radio/channels"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url ];
    
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSArray *Channels =resultDict[@"channels"];
    channelList = [HQChannels objectArrayWithKeyValuesArray:Channels];
    return channelList;
}
//+(void)getSongsInfo:(NSArray *)channel pathRow:(NSNumber *)pathRow
//{
//    HQChannels *Channels =channel[pathRow];
//    NSString *channelId =Channels.channel_id;
//    NSLog(@"%@",channelId);
//    /**
//     * 将字符串拼接成网址
//     */
//    NSString *str=[NSString stringWithFormat:@"http://www.douban.com/j/app/radio/people?app_name=radio_android&version=100&channel=""%@""&type=n",channelId];
//    //    NSURL *url1 =[NSURL URLWithString:@"http://www.douban.com/j/app/radio/people?app_name=radio_android&version=100&channel=%@&type=n",channelId];
//    NSURL *url1=[NSURL URLWithString:str];
//    //    NSLog(@"%@",url1);
//    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
//    
//    //将请求的url数据放到NSData对象中
//    NSData *response1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
//    
//    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:response1 options:NSJSONReadingMutableContainers error:nil];
//    //    NSLog(@"%@",song);
//    
//    NSArray *dic =resultDict[@"song"];
//    NSLog(@"%@",dic);
//    songList *songs =[songList mj_objectWithKeyValues:dic[0]];
//    //    songList *song =[[songList alloc]init];
//    //    NSString *url = song.url;
//    NSString *url =songs.url;
//
//    
//}
@end
