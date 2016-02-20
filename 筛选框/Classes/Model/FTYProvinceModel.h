//
//  FTYProvinceModel.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTYProvinceModel : NSObject
/**
 *  省内城市
 */
@property (strong, nonatomic) NSArray *children;
/**
 *  中国地区
 */
@property (copy, nonatomic) NSString *g_name;
/**
 *  地区编号
 */
@property (strong, nonatomic) NSNumber *gid;
/**
 *  省名称
 */
@property (strong, nonatomic) NSString *name;
/**
 *  省编号
 */
@property (strong, nonatomic) NSString *no;
/**
 *  order
 */
@property (strong, nonatomic) NSNumber *order;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)provinceModelWithDict:(NSDictionary *)dict;
@end
