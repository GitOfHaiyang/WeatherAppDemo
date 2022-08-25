//
//  YHYLifeIndexItem.m
//  HomePwner
//
//  Created by ByteDance on 2022/8/14.
//  Copyright © 2022 Big Nerd Ranch. All rights reserved.
//

#import "YHYLifeIndexItem.h"
#import "MJExtension.h"

@interface YHYLifeIndexItem ()

@end

@implementation YHYLifeIndexItem

- (instancetype)initwithArray:(NSArray *)lifeIndexData {
    _desc = [NSMutableArray array];
    _name = [NSMutableArray array];
    _status = [NSMutableArray array];
    for (int i = 0; i < lifeIndexData.count; i++) {
        [_status addObject:[lifeIndexData[i] objectForKey:@"status"]];
        [_desc addObject:[lifeIndexData[i] objectForKey:@"desc"]];
        [_name addObject:[lifeIndexData[i] objectForKey:@"name"]];
    }
    return self;
}



@end
