//
//  LoveListViewController.m
//  HQ_Music
//
//  Created by hongqing on 16/1/11.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "LoveListViewController.h"
#import "AppDelegate.h"
#import "songList.h"
#import "MJExtension.h"
#import <CoreData/CoreData.h>
@interface LoveListViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) NSDictionary *songDictionary;
@property(strong,nonatomic)songList *songs;
@property (nonatomic, retain) NSMutableArray *fetchedObjects;
@end
@implementation LoveListViewController

-(void)viewDidLoad
{
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    _songDictionary =appdelegate.delegateDictionary;
//    _songs =[songList mj_objectWithKeyValues:_songDictionary];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    NSManagedObjectContext *context =appdelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LoveSongs" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    NSLog(@"%@",_fetchedObjects);
   
        [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
//    cell.textLabel.text =@"hong";
//    for(songList *songs in _fetchedObjects)
    songList *songs =_fetchedObjects[indexPath.row];
    
//    {
    cell.textLabel.text =songs.title;
    cell.detailTextLabel.text =songs.artist;
//    }
//    if (_songs.loved ) {
//        cell.textLabel.text =_songs.title;
//        cell.detailTextLabel.text =_songs.artist;
//    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    songList *songs =_fetchedObjects[indexPath.row];
    
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *selectedObject = [self.fetchedObjects objectAtIndex:[indexPath row]];
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    [context deleteObject:selectedObject];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.fetchedObjects removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
