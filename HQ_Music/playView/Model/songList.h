//
//  songList.h
//  HQ_Music
//
//  Created by hongqing on 16/1/5.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface songList : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic,assign)NSNumber *length;
@property(nonatomic, assign,getter=isLoved) BOOL loved;

@end
