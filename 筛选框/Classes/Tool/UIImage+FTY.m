//
//  UIImage+FTY.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "UIImage+FTY.h"

@implementation UIImage (FTY)
/**
 *  图片拉伸
 *
 *  @param widthFraction  总宽几分之几处
 *  @param heightFraction 总高几分之几处
 *
 *  @return 被拉伸的图片
 */
- (UIImage *)stretchableImageWithCapWidthFraction:(CGFloat)widthFraction
                                CapHeightFraction:(CGFloat)heightFraction
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * widthFraction
                                     topCapHeight:self.size.height * heightFraction];
}
@end
