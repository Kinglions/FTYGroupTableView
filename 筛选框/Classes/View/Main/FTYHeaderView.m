//
//  FTYHeaderView.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#define UIColorFromRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define TGSystemColorLine           UIColorFromRGB16(0xe0e0e0) //分割线颜色
#define TGSystemFontTitle           [UIFont systemFontOfSize:16]//一级标题

#import "FTYHeaderView.h"
#import "FTYCustomButton.h"

@interface FTYHeaderView ()
@property (strong, nonatomic) FTYCustomButton *buttonArea;
@property (strong, nonatomic) FTYCustomButton *buttonType;
@property (strong, nonatomic) FTYCustomButton *buttonStage;
@property (weak, nonatomic) UILabel *lineArea;
@property (weak, nonatomic) UILabel *lineType;
@property (weak, nonatomic) UILabel *lineStage;
@end

@implementation FTYHeaderView
- (instancetype)init{
    
    if(self = [super init]){
        
        // 处理视图
        [self proccessView];
    }
    return self;
}

#pragma mark - 私有方法

- (void)proccessView{
    
    // 添加自定义按钮
    self.buttonArea = ({
         FTYCustomButton *areaBtn = [[FTYCustomButton alloc] initWithButtonType:ImageRightButtonTypeSearchProjectView];
        [areaBtn addTarget:self action:@selector(clickAreaBtn) forControlEvents:UIControlEventTouchUpInside];
        [areaBtn setTitle:@"全国" forState:UIControlStateNormal];
        areaBtn;
    });
    [self addSubview:self.buttonArea];
    
    self.buttonType = ({
         FTYCustomButton *typeBtn = [[FTYCustomButton alloc] initWithButtonType:ImageRightButtonTypeSearchProjectView];
        [typeBtn addTarget:self action:@selector(clickTypeBtn) forControlEvents:UIControlEventTouchUpInside];
        [typeBtn setTitle:@"所有类型" forState:UIControlStateNormal];
        typeBtn;
    });
    [self addSubview:self.buttonType];
    
    self.buttonStage = ({
         FTYCustomButton *stageBtn = [[FTYCustomButton alloc] initWithButtonType:ImageRightButtonTypeSearchProjectView];
        [stageBtn addTarget:self action:@selector(clickStageBtn) forControlEvents:UIControlEventTouchUpInside];
        [stageBtn setTitle:@"所有阶段" forState:UIControlStateNormal];
        stageBtn;
    });
    [self addSubview:self.buttonStage];
    
    // 添加分割线
    UILabel *areaLable = [[UILabel alloc] init];
    areaLable.backgroundColor = TGSystemColorLine;
    self.lineArea = areaLable;
    [self addSubview:areaLable];
    
    UILabel *typeLable = [[UILabel alloc] init];
    typeLable.backgroundColor = TGSystemColorLine;
    self.lineType = typeLable;
    [self addSubview:typeLable];
    
    UILabel *stageLable = [[UILabel alloc] init];
    stageLable.backgroundColor = TGSystemColorLine;
    self.lineStage = stageLable;
    [self addSubview:stageLable];
}


/**
 *  点击全国的按钮
 */
- (void)clickAreaBtn{
    self.buttonArea.selected = !self.buttonArea.selected;
    self.buttonType.selected = NO;
    self.buttonStage.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(headerView:ToFilterType:didSelect:)]) {
        [self.delegate headerView:self ToFilterType:ProjectFilterTypeForArea didSelect:self.buttonArea.selected];
    }
    
}

/**
 *  点击所有类型的按钮
 */
- (void)clickTypeBtn{
    self.buttonArea.selected = NO;
    self.buttonType.selected = !self.buttonType.selected ;
    self.buttonStage.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(headerView:ToFilterType:didSelect:)]) {
        [self.delegate headerView:self ToFilterType:ProjectFilterTypeForType didSelect:self.buttonType.selected];
    }
}

/**
 *  点击所有阶段的按钮
 */
- (void)clickStageBtn{
    self.buttonArea.selected = NO;
    self.buttonType.selected = NO;
    self.buttonStage.selected = !self.buttonStage.selected;
    
    if ([self.delegate respondsToSelector:@selector(headerView:ToFilterType:didSelect:)]) {
        [self.delegate headerView:self ToFilterType:ProjectFilterTypeForStage didSelect:self.buttonStage.selected];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / 3.0;
    CGFloat height = self.frame.size.height;
    self.buttonArea.frame = CGRectMake(0, 0, width, height);
    self.buttonType.frame = CGRectMake(CGRectGetMaxX(self.buttonArea.frame), 0, width, height);
    self.buttonStage.frame = CGRectMake(CGRectGetMaxX(self.buttonType.frame), 0, width, height);
    
    // 分割线
    self.lineArea.frame = CGRectMake(CGRectGetMaxX(self.buttonArea.frame), 0, 1, height);
    self.lineType.frame = CGRectMake(CGRectGetMaxX(self.buttonType.frame), 0, 1, height);
    self.lineStage.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    
}

- (void)changeHeaderViewButtonAreaTitle:(NSString *)areaTitle typeTitle:(NSString *)typeTitle stageTitle:(NSString *)stageTitle{

    self.buttonArea.selected = NO;
    self.buttonStage.selected = NO;
    self.buttonType.selected = NO;
    if (areaTitle != nil && ![areaTitle isEqualToString:@""]) {
        [self.buttonArea setTitle:areaTitle forState:UIControlStateNormal];
    } else {
        [self.buttonArea setTitle:@"全国" forState:UIControlStateNormal];
    }
    
    if (typeTitle != nil && ![typeTitle isEqualToString:@""]) {
        [self.buttonType setTitle:typeTitle forState:UIControlStateNormal];
    } else {
        [self.buttonType setTitle:@"所有类型" forState:UIControlStateNormal];
    }
    
    if (stageTitle != nil && ![stageTitle isEqualToString:@""]) {
        [self.buttonStage setTitle:stageTitle forState:UIControlStateNormal];
    } else {
        [self.buttonStage setTitle:@"所有阶段" forState:UIControlStateNormal];
    }
    
    
}

@end
