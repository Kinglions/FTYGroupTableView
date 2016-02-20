//
//  FTYCityModel.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "FTYCityModel.h"

@implementation FTYCityModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cityModelWithDict:(NSDictionary *)dict{
    
    return [[FTYCityModel alloc] initWithDict:dict];
}
@end
