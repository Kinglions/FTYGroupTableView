//
//  FTYTypeModel.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "FTYTypeModel.h"

@implementation FTYTypeModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)typeWithDict:(NSDictionary *)dict{
    
    return [[FTYTypeModel alloc] initWithDict:dict];
}
@end
