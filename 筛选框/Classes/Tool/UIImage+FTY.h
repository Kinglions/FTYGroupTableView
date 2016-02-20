//
//  UIImage+FTY.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FTY)
/**
 *  图片拉伸
 *
 *  @param widthFraction  总宽几分之几处
 *  @param heightFraction 总高几分之几处
 *
 *  @return 被拉伸的图片
 */
- (UIImage *)stretchableImageWithCapWidthFraction:(CGFloat)widthFraction
                                CapHeightFraction:(CGFloat)heightFraction;
@end
