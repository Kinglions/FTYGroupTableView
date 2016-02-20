//
//  FTYCustomButton.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//  返回一个带有图片的按钮

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageRightButtonType) {
    
    ImageRightButtonTypeSearchProjectView,
    
    ImageRightButtonTypeGroupProjectView,
    
    ImageRightButtonTypeIndicator,//右边为指示器箭头
};

@interface FTYCustomButton : UIButton

/**
 *  按钮右边指示器的类型
 */
@property (nonatomic,assign) ImageRightButtonType type;
/**
 *  初始化
 *
 *  @param type 按钮右边指示器的类型
 *
 *  @return 返回一个自定义按钮
 */
- (id)initWithButtonType:(ImageRightButtonType)type;
@end
