//
//  PlayViewController.m
//  HQ_Music
//
//  Created by hongqing on 15/12/23.
//  Copyright © 2015年 hongqing. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FSAudioStream.h"
#import "songList.h"
#import "ChannelListTableViewController.h"
#import "AppDelegate.h"
#import "MJExtension.h"
@interface PlayViewController()
@property(strong,nonatomic)AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) FSAudioStream *audioStream;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSDictionary *songDictionary1;
//@property(strong,nonatomic)ChannelListTableViewController *channelListViewController;
@property (weak, nonatomic) IBOutlet UIImageView *songImage;
- (IBAction)playBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn1;

@end

@implementation PlayViewController
//-(void)PassSongsInfo:(NSString *)url picture:(NSString *)picture artist:(NSString *)artist
//{
//    _url =url;
//    NSLog(@"%@",_url);
//    _picture =picture;
//    _artist =artist;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    ChannelListTableViewController *viewController =[[ChannelListTableViewController alloc]init];
 
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    _songDictionary1 =appdelegate.delegateDictionary;
    songList *songs =[songList mj_objectWithKeyValues:_songDictionary1];
   
    /**
     * 怎么设置导航栏的标题显示两行文字
     * 第一行显示歌曲名称，第二行显示歌手名称
     */
    UILabel *label =[[UILabel alloc]init];
    label.numberOfLines =2;
    label.text =[NSString stringWithFormat:@"%@/%@",songs.title,songs.artist];
//    
//    NSString *title =[NSString stringWithFormat:@"%@%@",songs.title,songs.artist];
    
    self.navigationItem.title =label.text;
    _url =songs.url;
    NSURL *imageUrl =[NSURL URLWithString:songs.picture];
    NSData *data =[NSData dataWithContentsOfURL:imageUrl];
    [self.songImage setImage:[UIImage imageWithData:data]];
}

-(FSAudioStream *)audioStream{
    if (!_audioStream) {
        NSURL *url=[NSURL URLWithString:_url];
        //创建FSAudioStream对象
        _audioStream=[[FSAudioStream alloc]initWithUrl:url];
        _audioStream.onFailure=^(FSAudioStreamError error,NSString *description){
            NSLog(@"播放过程中发生错误，错误信息：%@",description);
        };
        _audioStream.onCompletion=^(){
            NSLog(@"播放完成!");
        };
        [_audioStream setVolume:0.5];//设置声音
    }
    return _audioStream;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playBtn {
//    [_playBtn1 setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_playBtn1 setImage:[UIImage imageNamed:@"pause-2"]forState:UIControlStateSelected];
    [self.audioStream play];
}
@end
