//
//  FTYStageModel.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTYStageModel : NSObject
/**
 *  阶段名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  阶段编号
 */
@property (copy, nonatomic) NSString *no;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)stageWithDict:(NSDictionary *)dict;
@end
