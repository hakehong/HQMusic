//
//  ChannelListTableViewController.m
//  HQ_Music
//
//  Created by hongqing on 15/12/23.
//  Copyright © 2015年 hongqing. All rights reserved.
//

#import "ChannelListTableViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "PlayViewController.h"
#import "HQChannels.h"
#import "songList.h"
#import "HttpTool.h"
#import "AppDelegate.h"
@interface ChannelListTableViewController ()
@property(strong,nonatomic)PlayViewController *playView;
@property(copy,nonatomic)NSArray *channelList;

@property(copy,nonatomic)NSArray *songsInfo;
@property (nonatomic, copy) NSDictionary *songsDictionary;
@end

@implementation ChannelListTableViewController
- (void)setDelegate:(id <PassSongsInfoDelegate>) passDelegatee
{
    self.passDelegate = passDelegatee;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.passDelegate =self.playView;
    /**
     * 使用的AFNetworking3.0，AFHTTPRequestOperationManager修改为AFHTTPSessionManager
     */
    /*
    NSURL *url =[NSURL URLWithString:@"http://www.douban.com/j/app/radio/channels"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url ];
    
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    */
//    NSLog(@"%@",channels);
   
//    _channelList=channels[@"channels"];
    self.channelList = [HttpTool getChannelList:_channelList];
//    NSArray *Channels =resultDict[@"channels"];
//    self.channelList = [HQChannels objectArrayWithKeyValuesArray:Channels];
//    NSLog(@"%@",channelList);
//    for(int i=0;i<channelList.count;i++)
//    {
//        [_channelName addObject:channelList[i][@"name"]];
////        NSLog(@"%@",channelList[i][@"name"]);
//    }
//    NSLog(@"%@",_channelName);
//     for(id name in channelList)
//     {
//         [_channelName addObject:[channelList valueForKey:@"name"]];
//         
//     }
//    NSLog(@"%@",_channelName);
//    //获取数组list的内容
//    NSArray *name = channelList[@"name"];
//    NSLog(@"list数组的内容为--》%@", name );
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _channelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
     //cell.textLabel.text =channelName[indexPath.row];
    // Configure the cell...
//    cell.textLabel.text =_channelList[indexPath.row][@"name"];
    HQChannels *Channels =self.channelList[indexPath.row];
    cell.textLabel.text =Channels.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     * 点击某一个电台频道，然后传递频道ID，跳转到播放界面，播放歌曲。
     */
//    NSString *channelId=[NSString stringWithFormat:_channelList[indexPath.row][@"channel_id"]];
    HQChannels *Channels =self.channelList[indexPath.row];
    NSString *channelId =Channels.channel_id;
    NSLog(@"%@",channelId);
    /**
     * 将字符串拼接成网址
     */
    NSString *str=[NSString stringWithFormat:@"http://www.douban.com/j/app/radio/people?app_name=radio_android&version=100&channel=""%@""&type=n",channelId];
//    NSURL *url1 =[NSURL URLWithString:@"http://www.douban.com/j/app/radio/people?app_name=radio_android&version=100&channel=%@&type=n",channelId];
    NSURL *url1=[NSURL URLWithString:str];
//    NSLog(@"%@",url1);
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    //将请求的url数据放到NSData对象中
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
    
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:response1 options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",song);
    
    NSArray *dic =resultDict[@"song"];
    /**
     *  每个电台里面7首歌曲，在数组dic里面切换
     */
//    NSDictionary *dictionary =dic[0];
    self.songsDictionary=dic[0];
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    appdelegate.delegateDictionary = self.songsDictionary;
//    NSLog(@"%@",dic);
//   songList *songs =[songList mj_objectWithKeyValues:dictionary];
//    self.playView.songs =[songList mj_objectWithKeyValues:dictionary];
//   self.songsInfo =[songList objectArrayWithKeyValuesArray:dictionary];
//    objectArrayWithKeyValuesArray
    //    songList *song =[[songList alloc]init];
//    NSString *url = song.url;
//     _MusicUrl =songs.url;
//     _MusicPicture =songs.picture;
//     _MusicArtist =songs.artist;
//    _playView.url1 = MusicUrl;
//    self.playView.picture1 =songs.picture;
//    self.playView.album1 =songs.album;
//    self.playView.artist1=songs.artist;
//   NSLog(@"%@",MusicUrl);
//       NSLog(@"%@",MusicPicture);
////   NSLog(@"%@",self.playView.url1);
//    
//    [self.passDelegate PassSongsInfo:MusicUrl picture:MusicPicture artist:MusicArtist];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.playView = [storyBoard instantiateViewControllerWithIdentifier:@"playView"];
//    NSNotification *notification =[NSNotification notificationWithName:@"passSongsInfo" object:self userInfo:self.songsDictionary];
//    //通过通知中心发送通知
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController pushViewController:self.playView animated:YES];
    

}

//设置每一行的高度
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
