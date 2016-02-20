//
//  FTYFooterView.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#define UIColorFromRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define TGSystemColorBlue           UIColorFromRGB16(0x1177ff) //可点击的文字
#define BLUECOLOR   TGSystemColorBlue
#define TGSystemColorBlackTitle     UIColorFromRGB16(0x333333) //一级标题


#define FootViewHeight 44
#define SelfWidth self.frame.size.width
#define SelfHeight self.frame.size.height

#import "FTYFooterView.h"

@interface FTYFooterView ()
/**
 *  确定筛选
 */
@property (weak, nonatomic) UIButton *btnSave;
/**
 *  清空所有筛选
 */
@property (weak, nonatomic) UIButton *btnClear;
/**
 *  顶部分割线
 */
@property (weak, nonatomic) UILabel *lineHead;
/**
 *  中间分割线
 */
@property (weak, nonatomic) UILabel *lineMiddle;

@end

@implementation FTYFooterView
- (instancetype)init{
    
    if (self = [super init]) {
        
        // 背景颜色
        self.backgroundColor = [UIColor whiteColor];
        
        // 分割线
        UILabel *lineHead = [[UILabel alloc] init];
        lineHead.backgroundColor = [UIColor grayColor];
        lineHead.alpha = 0.5;
        self.lineHead = lineHead;
        [self addSubview:lineHead];
        
        // 确定按钮
        UIButton *buttonSave = [[UIButton alloc] init];
        [buttonSave setTitle:@"确定" forState:UIControlStateNormal];
        [buttonSave setTitleColor:BLUECOLOR forState:UIControlStateNormal];
        [buttonSave addTarget:self action:@selector(clickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.btnSave = buttonSave;
        [self addSubview:buttonSave];
        
        // 清空所有选项的按钮
        UIButton *buttonClear = [[UIButton alloc] init];
        [buttonClear setTitle:@"清空已选" forState:UIControlStateNormal];
        [buttonClear setTitleColor:TGSystemColorBlackTitle forState:UIControlStateNormal];
        [buttonClear addTarget:self action:@selector(clickClearBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.btnClear = buttonClear;
        [self addSubview:buttonClear];
        
        // 分割线
        UILabel *lineMiddle = [[UILabel alloc] init];
        lineMiddle.alpha = 0.5;
        lineMiddle.backgroundColor = [UIColor grayColor];
        self.lineMiddle = lineMiddle;
        [self addSubview:lineMiddle];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 分割线
    self.lineHead.frame = CGRectMake(0, 0, SelfWidth, 1);
    
    // 确定按钮
    self.btnSave.frame = CGRectMake(SelfWidth/2, 0, SelfWidth/2, FootViewHeight);
    
    // 清空所有选项的按钮
    self.btnClear.frame = CGRectMake(0, 0, SelfWidth/2, FootViewHeight);
    
    // 分割线
    self.lineMiddle.frame = CGRectMake(CGRectGetMaxX(self.btnClear.frame), 0, 1, FootViewHeight);
}


/**
 *  点击按钮通知代理
 */
- (void)clickSaveBtn:(UIButton *)button{
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(footerView:didClickSaveButton:)]) {
        [self.delegate footerView:self didClickSaveButton:button];
    }
}
/**
 *  点击按钮通知代理
 */
- (void)clickClearBtn:(UIButton *)button{
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(footerView:didClickClearButton:)]) {
        [self.delegate footerView:self didClickClearButton:button];
    }
}

@end
