//
//  MainTableViewController.m
//  HQ_Music
//
//  Created by hongqing on 15/12/23.
//  Copyright © 2015年 hongqing. All rights reserved.
//

#import "MainTableViewController.h"
#import "PlayViewController.h"
#import "ChannelListTableViewController.h"
#import "AppDelegate.h"
@interface MainTableViewController()<UITableViewDataSource,UITableViewDelegate>
//@property(strong,nonatomic)PlayViewController *playView;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem =
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    UIImage *musicImage =[UIImage imageNamed:@"cm2_list_icn_loading2"];
    self.navigationItem.title =@"我的音乐";
    self.navigationController.navigationBar.translucent =NO;
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:212/255.0 green:60/255.0 blue:51/255.0 alpha:0.0 ];
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithImage:musicImage style:UIBarButtonItemStyleDone target:self action:@selector(pushPlayView)];
    
    
}
-(void)pushPlayView
{
    NSLog(@"pushPlayView");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PlayViewController *playView = [storyBoard instantiateViewControllerWithIdentifier:@"playView"];
    [self.navigationController pushViewController:playView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0)
    {
        return 4;
    }else
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.section ==0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text =@"下载音乐";
                [cell.imageView setImage:[UIImage imageNamed:@"cm2_lay_icn_dld"]];
                break;
            case 1:
                cell.textLabel.text =@"最近播放";
                [cell.imageView setImage:[UIImage imageNamed:@"cm2_list_icn_recent"]];
                break;
            case 2:
                cell.textLabel.text =@"我的歌手";
                [cell.imageView setImage:[UIImage imageNamed:@"cm2_lay_icn_artist"]];
                break;
            case 3:
                cell.textLabel.text =@"我的电台";
                [cell.imageView setImage:[UIImage imageNamed:@"cm2_list_icn_rdi"]];
                break;
                
            default:
                break;
        }
    }
    else{
        cell.textLabel.text =@"我喜欢的音乐";
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 3:
                [self pushChannelListView];
                break;
                
            default:
                break;
        }
    }
}
-(void)pushChannelListView
{
    ChannelListTableViewController *ChannelListView =[[ChannelListTableViewController alloc]init];
    [self.navigationController pushViewController:ChannelListView animated:YES];
}
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
