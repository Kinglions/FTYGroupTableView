//
//  FTYHeaderView.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ProjectFilterType) {
    ProjectFilterTypeForArea,
    ProjectFilterTypeForType,
    ProjectFilterTypeForStage
};

@class FTYHeaderView;
@protocol FTYHeaderViewDelegate <NSObject>

@optional
/**
 *  点击过滤器的时候出发
 *
 *  @param projectFilterView 当前过滤器
 *  @param filterType        过滤类型
 *  @param selected          是否选中
 */
- (void)headerView:(FTYHeaderView *)headerView ToFilterType:(ProjectFilterType)filterType didSelect:(BOOL)selected;

@end

@interface FTYHeaderView : UIView
/**
 *  改变头部按钮的标题
 *
 *  @param areaTitle  省份
 *  @param typeTitle  类型
 *  @param stageTitle 阶段
 */
- (void)changeHeaderViewButtonAreaTitle:(NSString *)areaTitle typeTitle:(NSString *)typeTitle stageTitle:(NSString *)stageTitle;

@property (weak, nonatomic) id<FTYHeaderViewDelegate> delegate;

@end
