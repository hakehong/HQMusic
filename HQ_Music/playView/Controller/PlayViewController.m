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
#import <CoreData/CoreData.h>
@interface PlayViewController()
@property(strong,nonatomic)AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) FSAudioStream *audioStream;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSDictionary *songDictionary1;
//@property(strong,nonatomic)ChannelListTableViewController *channelListViewController;
@property (weak, nonatomic) IBOutlet UISlider *VolumeSlider;
@property (weak, nonatomic) IBOutlet UILabel *playTimes;
@property (weak, nonatomic) IBOutlet UILabel *songTimes;

@property (weak, nonatomic) IBOutlet UIImageView *songImage;
- (IBAction)playBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn1;
@property(strong,nonatomic)songList *songs;
- (IBAction)loveBtn:(UIButton *)sender;
- (IBAction)nextSongBtn:(UIButton *)sender;
- (IBAction)lastSongBtn:(UIButton *)sender;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _isPlaying = NO;
//    ChannelListTableViewController *viewController =[[ChannelListTableViewController alloc]init];
 
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    _songDictionary1 =appdelegate.delegateDictionary;
    _songs =[songList mj_objectWithKeyValues:_songDictionary1];
    [self.VolumeSlider setThumbImage:[UIImage imageNamed:@"Slider"] forState:UIControlStateNormal];
    NSString *totalStr=[NSString stringWithFormat:@"%@",self.songs.length];
    NSInteger total =[totalStr intValue];
    int seconds = total% 60;
    int minutes = total / 60;
    self.songTimes.text=[NSString stringWithFormat:@"%d:%d",minutes,seconds];
    /**
     * 怎么设置导航栏的标题显示两行文字
     * 第一行显示歌曲名称，第二行显示歌手名称
     */
//
//    label.numberOfLines =2;
//    label.text =[NSString stringWithFormat:@"%@/%@",_songs.title,_songs.artist];
////    
////    NSString *title =[NSString stringWithFormat:@"%@%@",songs.title,songs.artist];
//    
//    self.navigationItem.title =label.text;
    UIButton *button =[[UIButton alloc]init];
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    UILabel *label =[[UILabel alloc]init];
//    label.text =[NSString stringWithFormat:@"%@",_songs.artist];
//    label.font=[UIFont systemFontOfSize:10];
   NSString *title =[NSString stringWithFormat:@"%@\n%@",_songs.title,_songs.artist];
    [button setTitle: title forState: UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.navigationItem setTitleView:button];
    _url =_songs.url;
    NSURL *imageUrl =[NSURL URLWithString:_songs.picture];
    NSData *data =[NSData dataWithContentsOfURL:imageUrl];
    if (data) {
        [self.songImage setImage:[UIImage imageWithData:data]];
    }else
    {
        [self.songImage setImage:[UIImage imageNamed:@"cm2_play_disc_default"]];
    }
    
//    [_playBtn1 addTarget:self action:@selector(playMusic)forControlEvents:UIControlEventTouchUpInside];
}
//-(void)playMusic
//{
//    if (_playBtn1.tag ==1) {
//     [self.audioStream play];
//     [_playBtn1 setImage:[UIImage imageNamed:@"pause-2"]forState:UIControlStateNormal];
//        _playBtn1.tag =10;
//    }
//    else {
//        [self.audioStream pause];
//        [_playBtn1 setImage:[UIImage imageNamed:@"play"]forState:UIControlStateNormal];
//         _playBtn1.tag =1;
//    }
//}
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
        _audioStream.volume =self.VolumeSlider.value;
        
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
    
    
    if (_playing ==NO) {
        [self.audioStream play];
        [_playBtn1 setImage:[UIImage imageNamed:@"pause-2"]forState:UIControlStateNormal];
        _playing =YES;
    }
    else {
        [self.audioStream pause];
        [_playBtn1 setImage:[UIImage imageNamed:@"play"]forState:UIControlStateNormal];
        _playing =NO;
    }
    
}
- (IBAction)loveBtn:(UIButton *)sender {
    if (_songs.loved ==NO) {
        [sender setImage:[UIImage imageNamed:@"cm2_rdi_btn_loved-1"]forState:UIControlStateNormal];
        _songs.loved = YES;
        [self saveLoveSongs];
    }
    else {
        [sender setImage:[UIImage imageNamed:@"cm2_rcd_icn_love"]forState:UIControlStateNormal];
      
        _songs.loved =NO;
        
    }
}

- (IBAction)nextSongBtn:(UIButton *)sender
{
    
}

- (IBAction)lastSongBtn:(UIButton *)sender
{
    
}
-(void)saveLoveSongs
{
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context =appdelegate.managedObjectContext;
    NSManagedObject *songsInfo = [NSEntityDescription insertNewObjectForEntityForName:@"LoveSongs" inManagedObjectContext:context];
    [songsInfo setValue:_songs.artist  forKey:@"artist"];
//    [songsInfo setValue:_songs.loved forKey:@"loved"];
    [songsInfo setValue:_songs.picture forKey:@"picture"];
    [songsInfo setValue:_songs.title forKey:@"title"];
    [songsInfo setValue:_songs.url forKey:@"url"];
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
 
}
@end
