//
//  FTYMainView.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#define ZKB_NAVIGATION_BAR_HEIGHT_44 44.0
#define ZKB_NAVIGATION_BAR_HEIGHT_64 64.0
#define ZKB_IOS_VERSION_7         7.0
//TODO：可能出错
#define ZKB_NAVIGATION_BAR_HEIGHT ((ZKB_IOS_VERSION_OR_ABOVE(ZKB_IOS_VERSION_7)) ? ZKB_NAVIGATION_BAR_HEIGHT_64 : ZKB_NAVIGATION_BAR_HEIGHT_44)
//固件版本判断
#define ZKB_IOS_VERSION_OR_ABOVE(_version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= _version)? (YES):(NO))

#import "FTYMainView.h"
#import "FTYHeaderView.h"
#import "FTYFooterView.h"
#import "FTYAreaView.h"
#import "FTYTypeView.h"
#import "FTYStageView.h"

#import "FTYStageModel.h"

#import "FTYProjectTool.h"


@interface FTYMainView() <FTYFooterViewDelegate, FTYHeaderViewDelegate>
/**
 *  过滤框
 */
@property (strong, nonatomic) FTYHeaderView *headerView;
/**
 *  响应过滤框的选择器
 */
@property (weak, nonatomic) UIControl *controlShowFilterView;
@property (weak, nonatomic) UIControl *controlBG;
/**
 *  过滤器第一个选择
 */
@property (weak, nonatomic) FTYAreaView *areaFilterView;
/**
 *  过滤器第二个选择
 */
@property (weak, nonatomic) FTYTypeView *typeFilterView;
/**
 *  过滤器第三个选择
 */
@property (weak, nonatomic) FTYStageView *stageFilterView;
/**
 *  选择框底部的view
 */
@property (weak, nonatomic) FTYFooterView *footerView;

@end

@implementation FTYMainView
- (instancetype)init{
    
    if (self = [super init]) {
        
        // 初始化过滤框
        [self setupFilterView];
        
        // 初始化背景控制视图及底部
        [self setupControlFilterView];
    }
    return self;
}

/**
 *  初始化过滤框
 */
- (void)setupFilterView{
    
    FTYHeaderView *filterView = [[FTYHeaderView alloc] init];
    filterView.delegate = self;
    self.headerView = filterView;
    [self addSubview:filterView];
    
}

/**
 *  初始化背景控制视图及底部
 */
- (void)setupControlFilterView{
    
    UIControl *controlFilterView = [[UIControl alloc] init];
    self.controlShowFilterView = controlFilterView;
    
    UIControl *controlViewBG = [[UIControl alloc] init];
    self.controlBG = controlViewBG;
    [self.controlBG setHidden:YES];
    [self.controlBG setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    [self addSubview:controlFilterView];
    [self addSubview:controlViewBG];
    
    // 底部
    FTYFooterView *footerView = [[FTYFooterView alloc] init];
    footerView.hidden = YES;
    footerView.delegate = self;
    self.footerView = footerView;
    [self.controlShowFilterView addSubview:footerView];
}



- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat footViewHeight = ZKB_NAVIGATION_BAR_HEIGHT_44;
    CGFloat mainViewWidth = self.frame.size.width;
    CGFloat mainViewHeight = self.frame.size.height - ZKB_NAVIGATION_BAR_HEIGHT_64;
    
    self.headerView.frame = CGRectMake(0, ZKB_NAVIGATION_BAR_HEIGHT_64, self.frame.size.width, footViewHeight);
    
    self.controlShowFilterView.frame = CGRectMake(0, ZKB_NAVIGATION_BAR_HEIGHT + footViewHeight, mainViewWidth, mainViewHeight - footViewHeight);
    
    self.footerView.frame = CGRectMake(0, _controlShowFilterView.frame.size.height - footViewHeight, mainViewWidth, footViewHeight);
}



#pragma mark - FTYHeaderViewDelegate
- (void)headerView:(FTYHeaderView *)headerView ToFilterType:(ProjectFilterType)filterType didSelect:(BOOL)selected{
    
    CGFloat mainViewWidth = self.frame.size.width;
    CGFloat mainViewHeight = self.frame.size.height - ZKB_NAVIGATION_BAR_HEIGHT_64;
    
    
    // 设置动画
    CGFloat x = mainViewWidth/2.0;
    CGFloat y = ZKB_NAVIGATION_BAR_HEIGHT + ZKB_NAVIGATION_BAR_HEIGHT_44 + (self.controlShowFilterView.frame.size.height)/2.0;
    CAKeyframeAnimation *animationPath = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef aPath = CGPathCreateMutable();
    
    BOOL needAnimation = YES;
    
    // 选中（隐藏相关控件）
    if (selected) {
        BOOL isHidden = self.controlBG.hidden;
        [self.controlShowFilterView setAlpha:0.0];
        [self.areaFilterView setAlpha:0.0];
        [self.typeFilterView setAlpha:0.0];
        [self.stageFilterView setAlpha:0.0];
        [self.footerView setHidden:NO];
        [self.controlBG setHidden:NO];
        [self.controlShowFilterView setAlpha:1.0];
        if (isHidden) {
            self.controlShowFilterView.frame = CGRectMake(0, ZKB_NAVIGATION_BAR_HEIGHT + ZKB_NAVIGATION_BAR_HEIGHT_44, mainViewWidth, mainViewHeight - ZKB_NAVIGATION_BAR_HEIGHT_44);
            CGPathMoveToPoint(aPath, nil, x, y + self.frame.size.height);
            CGPathAddCurveToPoint(aPath, nil, x, y + 120, x, y + 40, x, y);
        } else {
            
            [self.controlShowFilterView setAlpha:0.0];
            [self.controlBG setBackgroundColor:[UIColor whiteColor]];
            [UIView animateWithDuration:0.3 animations:^{
                [self.controlShowFilterView setAlpha:1.0];
            } completion:^(BOOL finished) {
                [self.controlBG setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
            }];
            needAnimation = NO;
        }
        // 未选中
    } else {
        [self.controlBG setHidden:YES];
        CGPathMoveToPoint(aPath, nil, x, y);
        y = y + self.frame.size.height;
        [self.controlShowFilterView setFrame:CGRectMake(0, y, mainViewWidth, mainViewHeight - ZKB_NAVIGATION_BAR_HEIGHT_44)];
        CGPathAddCurveToPoint(aPath, nil, x, y - 120, x, y - 40, x, y);
    }
    
    
    // 动画
    if(needAnimation){
        animationPath.path = aPath;
        animationPath.duration = 0.2;
        animationPath.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [self.controlShowFilterView.layer addAnimation:animationPath forKey:@"position"];
    }
    
    
    
    // 类型选择
    switch (filterType) {
        case ProjectFilterTypeForArea: // 全国
            if (!self.areaFilterView) {
                
                FTYAreaView *areaView = [[FTYAreaView alloc] init];
                areaView.plistName = self.areaNoPlistName;
                self.areaFilterView = areaView;
                areaView.frame = CGRectMake(0, 0, mainViewWidth, self.controlShowFilterView.frame.size.height - ZKB_NAVIGATION_BAR_HEIGHT_44);
                self.areaFilterView = areaView;
                [self.controlShowFilterView addSubview:areaView];
            } else {
                [self.areaFilterView setAlpha:1.0];
            }
            break;
            
        case ProjectFilterTypeForType: // 全部类型
            if (!self.typeFilterView) {
                FTYTypeView *typeView = [[FTYTypeView alloc] init];
                typeView.plistName = self.typeNoPlistName;
                self.typeFilterView = typeView;
                typeView.frame = CGRectMake(0, 0, mainViewWidth, self.controlShowFilterView.frame.size.height - ZKB_NAVIGATION_BAR_HEIGHT_44);
                self.typeFilterView = typeView;
                [self.controlShowFilterView addSubview:typeView];
            } else {
                [self.typeFilterView setAlpha:1.0];
            }
            break;
        case ProjectFilterTypeForStage: // 全阶段
            if (!self.stageFilterView) {
                FTYStageView *stageView = [[FTYStageView alloc] init];
                stageView.plistName = self.stageNoPlistName;
                self.stageFilterView = stageView;
                stageView.frame = CGRectMake(0, 0, mainViewWidth, self.controlShowFilterView.frame.size.height - ZKB_NAVIGATION_BAR_HEIGHT_44);
                self.stageFilterView = stageView;
                [self.controlShowFilterView addSubview:stageView];
            } else {
                [self.stageFilterView setAlpha:1.0];
            }
            break;
        default:
            break;
            
    }
}

#pragma mark - FTYFooterViewDelegate
/**
 *  点击清空已选按钮
 */
- (void)footerView:(FTYFooterView *)footerView didClickClearButton:(UIButton *)button{
    
    NSLog(@"点击清空已选按钮");
    
    [self.areaFilterView setDicSelect:[NSMutableDictionary dictionary]];
    [self.typeFilterView setArrSelectedRow:[NSMutableArray array]];
    [self.stageFilterView setArrSelectedRow:[NSMutableArray array]];
    [self.areaFilterView reloadData];
    [self.typeFilterView reloadData];
    [self.stageFilterView reloadData];
}
/**
 *  点击确定按钮
 */
- (void)footerView:(FTYFooterView *)footerView didClickSaveButton:(UIButton *)button{
    
    NSLog(@"点击确定按钮");
    
    [self removeFilterView];
    
    NSString *typeName = [FTYProjectTool getTypeNameWithStages:self.typeFilterView.types didSelectedRows:self.typeFilterView.arrSelectedRow];
    NSString *stageName = [FTYProjectTool getStageNameWithStages:self.stageFilterView.stages didSelectedRows:self.stageFilterView.arrSelectedRow];
    NSString *provinceName = [FTYProjectTool getProvinceNameWithStages:self.areaFilterView.provinces didSelectedRows:self.areaFilterView.dicSelect];
    
    
    [self.headerView changeHeaderViewButtonAreaTitle:provinceName typeTitle:typeName stageTitle:stageName];
    

    
    
}

- (void)removeFilterView{
    [_controlBG setHidden:YES];
    [_controlShowFilterView setAlpha:0.0];
    [_areaFilterView setAlpha:0.0];
    [_typeFilterView setAlpha:0.0];
    [_stageFilterView setAlpha:0.0];
    
}

@end
