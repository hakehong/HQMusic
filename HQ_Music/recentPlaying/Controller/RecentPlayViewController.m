//
//  RecentPlayViewController.m
//  HQ_Music
//
//  Created by hongqing on 16/1/11.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "RecentPlayViewController.h"
#import "LoveListViewController.h"
#import "AppDelegate.h"
#import "songList.h"
#import "MJExtension.h"
#import <CoreData/CoreData.h>
@interface RecentPlayViewController()
@property (nonatomic, copy) NSDictionary *songDictionary;
@property(strong,nonatomic)songList *songs;
@property (nonatomic, retain) NSMutableArray *recentPlayingSongs;
@end
@implementation RecentPlayViewController
-(void)viewDidLoad
{
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        _songDictionary =appdelegate.delegateDictionary;
        _songs =[songList mj_objectWithKeyValues:_songDictionary];
     [self.recentPlayingSongs addObject:_songs];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.tableView reloadData];
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _recentPlayingSongs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    songList *songs =self.recentPlayingSongs[indexPath.row];
    cell.textLabel.text =songs.title;
    cell.detailTextLabel.text =songs.artist;
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

@end

