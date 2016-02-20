//
//  FTYProvinceTableViewCell.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//


//当前固件版本
#define ZKB_CURRENT_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define IOS7    ( ZKB_CURRENT_SYSTEM_VERSION >= 7.0)
#define IOS8    ( ZKB_CURRENT_SYSTEM_VERSION >= 8.0)

#define AREA_SELECT_PROVINCE_IMG_NORMAL         @"project_area_province_normal"
#define AREA_SELECT_PROVINCE_IMG_HIGHLIGHT      @"project_area_province_highlight"
#define AREA_SELECT_PROVINCE_IMG_ALERT          @"project_province_selected"



#import "FTYProvinceTableViewCell.h"
#import "FTYProvinceModel.h"

#import "UIImage+FTY.h"

@interface FTYProvinceTableViewCell()

@property (weak, nonatomic) UILabel *titleLable;

@property (weak, nonatomic) UIImageView *leftSelectedView;

/**
 *  背景view
 */
@property (weak, nonatomic) UIImageView *imageViewBG;

@end

@implementation FTYProvinceTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        while ([self.contentView.subviews lastObject] != nil) {
            [self.contentView.subviews.lastObject removeFromSuperview];
        }
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        // 背景图片
        UIImageView *imageViewBG = [[UIImageView alloc] init];
        self.imageViewBG = imageViewBG;
        [self.contentView addSubview:imageViewBG];
        
        // 标题
        UILabel *title = [[UILabel alloc] init];
        title.font = [UIFont systemFontOfSize:16];
        title.tintColor = [UIColor blackColor];
        self.titleLable = title;
        [imageViewBG addSubview:title];
        
        // 左边图标
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.contentMode = UIViewContentModeCenter;
        self.leftSelectedView = leftView;
        [imageViewBG addSubview:leftView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.leftSelectedView.frame = CGRectMake(5, 0, 20, 44);
    self.titleLable.frame = CGRectMake(30, 0, 75, 44);
    self.imageViewBG.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"province";
    FTYProvinceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FTYProvinceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    
    if(IOS7)
    {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if(IOS8){
        [tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    return cell;
}


- (void)setProvince:(FTYProvinceModel *)province{
    _province = province;
    
    self.titleLable.text = province.name;
    
}

- (void)setShowImageViewBG:(BOOL)showImageViewBG{
    
    _showImageViewBG = showImageViewBG;
    if (showImageViewBG) {
        UIImage *image = [UIImage imageNamed:AREA_SELECT_PROVINCE_IMG_HIGHLIGHT];
        self.imageViewBG.image = [image stretchableImageWithCapWidthFraction:0.5 CapHeightFraction:0.5];
    } else {
        
        UIImage *image = [UIImage imageNamed:AREA_SELECT_PROVINCE_IMG_NORMAL];
        self.imageViewBG.image = [image stretchableImageWithCapWidthFraction:0.5 CapHeightFraction:0.5];
    }
}

- (void)setShowLeftImageView:(BOOL)showLeftImageView{
    
    _showLeftImageView = showLeftImageView;
    if (showLeftImageView) {
        self.leftSelectedView.image = [UIImage imageNamed:AREA_SELECT_PROVINCE_IMG_ALERT];
    } else {
        self.leftSelectedView.image = nil;
    }
}

@end
