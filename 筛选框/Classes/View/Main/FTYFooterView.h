//
//  FTYFooterView.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FTYFooterView;
@protocol FTYFooterViewDelegate <NSObject>

@optional
/**
 *  点击确定按钮
 */
- (void)footerView:(FTYFooterView *)footerView didClickSaveButton:(UIButton *)button;
/**
 *  点击清空已选按钮
 */
- (void)footerView:(FTYFooterView *)footerView didClickClearButton:(UIButton *)button;

@end

@interface FTYFooterView : UIView
@property (weak, nonatomic) id<FTYFooterViewDelegate> delegate;

@end
