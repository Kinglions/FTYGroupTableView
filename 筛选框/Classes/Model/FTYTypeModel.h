//
//  FTYTypeModel.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTYTypeModel : NSObject
/**
 *  类型名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  类型编号
 */
@property (copy, nonatomic) NSString *no;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)typeWithDict:(NSDictionary *)dict;
@end
