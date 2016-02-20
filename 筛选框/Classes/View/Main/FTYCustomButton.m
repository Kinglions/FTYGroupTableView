//
//  FTYCustomButton.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#define TGSystemFontTitle           [UIFont systemFontOfSize:16]//一级标题

#import "FTYCustomButton.h"

@implementation FTYCustomButton
- (id)initWithButtonType:(ImageRightButtonType)type{
    
    if (self = [super init]) {
        self.type = type;
        if (type == ImageRightButtonTypeSearchProjectView) {
            [self setImage:[UIImage imageNamed:@"option_triangle_down"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"option_triangle_up"] forState:UIControlStateSelected];
        }else if(type == ImageRightButtonTypeIndicator){
            [self setImage:[UIImage imageNamed:@"cell_detail"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"cell_detail"] forState:UIControlStateSelected];
        }else {
            [self setImage:[UIImage imageNamed:@"choose_btn_down"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"choose_btn_up"] forState:UIControlStateSelected];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = TGSystemFontTitle;
        self.backgroundColor = [UIColor whiteColor];
        [self.imageView setContentMode:UIViewContentModeCenter];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width;
    CGFloat buttonH = self.frame.size.height;
    
    CGFloat imageW = self.imageView.image.size.width;
    CGFloat maxTitleW = buttonW - 25 - imageW;
    
    NSString *title = self.titleLabel.text;
    CGSize titleSize = [title sizeWithFont:TGSystemFontTitle constrainedToSize:CGSizeMake(maxTitleW, buttonH)];
    
    CGFloat titleW = titleSize.width;
    if (titleW > maxTitleW) {
        titleW = maxTitleW;
    }
    
    CGFloat totalW = titleW+5+imageW;
    CGFloat margin = (buttonW - totalW)*0.5;
    if (self.type == ImageRightButtonTypeSearchProjectView) {
        self.titleLabel.frame = CGRectMake(margin, 0, titleW, buttonH);
        self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, imageW, buttonH);
    }else if(self.type == ImageRightButtonTypeIndicator){
        self.titleLabel.frame = CGRectMake(margin, 0, titleW, buttonH);
        self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, imageW, buttonH);
    }else {
        self.titleLabel.frame = CGRectMake(10, 0, titleW, buttonH);
        self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, imageW, buttonH);
        
    }
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
