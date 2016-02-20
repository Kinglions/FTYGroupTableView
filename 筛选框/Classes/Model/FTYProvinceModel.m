//
//  FTYProvinceModel.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "FTYProvinceModel.h"
#import "FTYCityModel.h"

@implementation FTYProvinceModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *cityM = [NSMutableArray array];
        for (NSDictionary *dictM in _children) {
            FTYCityModel *city = [FTYCityModel cityModelWithDict:dictM];
            [cityM addObject:city];
        }
        _children = cityM;
        
    }
    return self;
}

+ (instancetype)provinceModelWithDict:(NSDictionary *)dict{
    
    return [[FTYProvinceModel alloc] initWithDict:dict];
}
@end
