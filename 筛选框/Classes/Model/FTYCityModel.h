//
//  FTYCityModel.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTYCityModel : NSObject
/**
 *  市内县区
 */
@property (strong, nonatomic) NSArray *children;
/**
 *  城市名称
 */
@property (strong, nonatomic) NSString *name;
/**
 *  城市编号
 */
@property (strong, nonatomic) NSString *no;
/**
 *  order
 */
@property (strong, nonatomic) NSNumber *order;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cityModelWithDict:(NSDictionary *)dict;

@end
