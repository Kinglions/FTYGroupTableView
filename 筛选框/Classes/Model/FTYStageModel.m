//
//  FTYStageModel.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "FTYStageModel.h"

@implementation FTYStageModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)stageWithDict:(NSDictionary *)dict{
    
    return [[FTYStageModel alloc] initWithDict:dict];
}
@end
