//
//  FTYTypeTableViewCell.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

//当前固件版本
#define ZKB_CURRENT_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define IOS7    ( ZKB_CURRENT_SYSTEM_VERSION >= 7.0)
#define IOS8    ( ZKB_CURRENT_SYSTEM_VERSION >= 8.0)

// 指示view的图片
#define AREA_SELECT_CITY_IMG_NORMAL             @"center_checkbox_normal"
#define AREA_SELECT_CITY_IMG_SELECTED           @"center_checkbox_selected"

#import "FTYTypeTableViewCell.h"
#import "FTYTypeModel.h"

@interface FTYTypeTableViewCell ()

@property (weak, nonatomic) UIImageView *typeImageView;
@property (weak, nonatomic) UILabel *typeTitle;


@end

@implementation FTYTypeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"type";
    FTYTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FTYTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}



- (void)setType:(FTYTypeModel *)type{
    
    _type = type;
    self.textLabel.text = type.name;
    
}

- (void)setShowLeftImageView:(BOOL)showLeftImageView{
    
    _showLeftImageView = showLeftImageView;
    if (showLeftImageView) {
        self.imageView.image = [UIImage imageNamed:AREA_SELECT_CITY_IMG_SELECTED];
    } else {
        self.imageView.image = [UIImage imageNamed:AREA_SELECT_CITY_IMG_NORMAL];
    }
}

@end
