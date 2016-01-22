//
//  HqTabBraViewController.m
//  weibo
//
//  Created by hongqing on 15/12/6.
//  Copyright © 2015年 hongqing. All rights reserved.
//

#import "HqTabBraViewController.h"
#import "ChannelListTableViewController.h"
#import "LoveListViewController.h"
#import "DownloadMusicViewController.h"
#import "RecentPlayViewController.h"
@interface HqTabBraViewController ()

@end

@implementation HqTabBraViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   ChannelListTableViewController  *radio = [[ChannelListTableViewController alloc]init];
    [self addchildVC:radio title:@"电台频道" imageName:@"cm2_list_icn_rdi" selectedImageName:@"cm2_list_icn_rdi"];
    
    DownloadMusicViewController *download = [[DownloadMusicViewController alloc]init];
    [self addchildVC:download title:@"下载音乐" imageName:@"cm2_lay_icn_dld" selectedImageName:@"cm2_lay_icn_dld"];
    
    LoveListViewController *loved = [[LoveListViewController alloc]init];
    [self addchildVC:loved title:@"喜欢的音乐" imageName:@"cm2_rdi_btn_loved-1" selectedImageName:@"cm2_rdi_btn_loved-1"];
    
    RecentPlayViewController  *recent = [[RecentPlayViewController alloc]init];
    [self addchildVC:recent title:@"最近播放" imageName:@"cm2_list_icn_recent" selectedImageName:@"cm2_list_icn_recent"];
  
    
}
-(void)addchildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
//    childVC.view.backgroundColor = HqRandomColor;
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
//  设置tabBarItem的文字颜色,普通状态下
    NSMutableDictionary *textAttrs =[[NSMutableDictionary alloc]init];
    textAttrs[UITextAttributeTextColor]=[UIColor blackColor];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//  设置文字高亮情况下颜色
    NSMutableDictionary *HighTextAttrs =[[NSMutableDictionary alloc]init];
    HighTextAttrs[UITextAttributeTextColor]=[UIColor redColor];
    [childVC.tabBarItem setTitleTextAttributes:HighTextAttrs forState:UIControlStateHighlighted];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImage;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVC];
//    212 60 51
//    nav.navigationBar.barTintColor =[UIColor colorWithRed:212.0/255 green:60.0/255 blue:51.0/255 alpha:1];
    [self  addChildViewController:nav];

}
@end
