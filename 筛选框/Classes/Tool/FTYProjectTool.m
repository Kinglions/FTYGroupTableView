//
//  FTYProjectTool.m
//  筛选框
//
//  Created by tgnetMAC on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "FTYProjectTool.h"
#import "FTYStageModel.h"
#import "FTYTypeModel.h"
#import "FTYProvinceModel.h"
#import "FTYCityModel.h"



@implementation FTYProjectTool
/**
 *  获取选中的省份的名称
 *
 *  @param stages       阶段模型数组
 *  @param selectedRows 选中的模型数组
 *
 *  @return 选中的最后一个名称
 */
+ (NSString *)getProvinceNameWithStages:(NSArray *)stages didSelectedRows:(NSDictionary *)selectedRows{
    
    NSString *name = @"";
    NSArray *provinceArr = [selectedRows allKeys];
    NSArray *cityArr = [selectedRows allValues];
    for (int i = 0; i<provinceArr.count; i++) {
        NSInteger row = [provinceArr[i] integerValue];
        FTYProvinceModel *provinceModel = stages[row];
        for (int j = 0; j<cityArr.count; j++) {
            NSArray *cityRows = cityArr[j];

            for (int k = 0; k<cityRows.count; k++) {
                FTYCityModel *cityModel = provinceModel.children[k];
                if ([cityRows[k] integerValue] == 0) {
                    // 选中所有城市，返回省份名称
                    name = provinceModel.name;
                } else {
                    // 选中一些城市
                    name = cityModel.name;
                }
            }
        }
    }
    return name;
}
/**
 *  获取选中的类型的名称
 *
 *  @param stages       阶段模型数组
 *  @param selectedRows 选中的模型数组
 *
 *  @return 选中的最后一个名称
 */
+ (NSString *)getTypeNameWithStages:(NSArray *)stages didSelectedRows:(NSArray *)selectedRows{
    NSString *typeName = @"";
    for (int i = 0; i<selectedRows.count; i++) {
        NSInteger row = [selectedRows[i] integerValue];
        FTYTypeModel *model = stages[row];
        typeName = model.name;
    }
    return typeName;
}
/**
 *  获取选中的阶段的名称
 *
 *  @param stages       阶段模型数组
 *  @param selectedRows 选中的模型数组
 *
 *  @return 选中的最后一个名称
 */
+ (NSString *)getStageNameWithStages:(NSArray *)stages didSelectedRows:(NSArray *)selectedRows{
    NSString *stageName = @"";
    for (int i = 0; i<selectedRows.count; i++) {
        NSInteger row = [selectedRows[i] integerValue];
        FTYStageModel *model = stages[row];
        stageName = model.name;
    }
    return stageName;
}

@end
