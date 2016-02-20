//
//  FTYProjectTool.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTYProjectTool : NSObject
/**
 *  获取选中的省份的名称
 *
 *  @param stages       阶段模型数组
 *  @param selectedRows 选中的模型数组
 *
 *  @return 选中的最后一个名称
 */
+ (NSString *)getProvinceNameWithStages:(NSArray *)stages didSelectedRows:(NSDictionary *)selectedRows;
/**
 *  获取选中的类型的名称
 *
 *  @param stages       阶段模型数组
 *  @param selectedRows 选中的模型数组
 *
 *  @return 选中的最后一个名称
 */
+ (NSString *)getTypeNameWithStages:(NSArray *)stages didSelectedRows:(NSArray *)selectedRows;
/**
 *  获取选中的阶段的名称
 *
 *  @param stages       阶段模型数组
 *  @param selectedRows 选中的模型数组
 *
 *  @return 选中的最后一个名称
 */
+ (NSString *)getStageNameWithStages:(NSArray *)stages didSelectedRows:(NSArray *)selectedRows;

@end