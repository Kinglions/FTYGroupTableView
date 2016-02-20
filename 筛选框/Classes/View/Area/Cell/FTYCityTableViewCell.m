//
//  FTYCityTableViewCell.m
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

#import "FTYCityTableViewCell.h"
#import "FTYCityModel.h"

@interface FTYCityTableViewCell()
@property (weak, nonatomic) UIView *viewContent;

/**
 *  选中一行
 */
@property (assign, nonatomic, getter=isDidSelected) BOOL didSelected;
/**
 *  城市cell右边的指示图片
 */
@property (strong, nonatomic) UIImageView *accessView;

@end

@implementation FTYCityTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"city";
    FTYCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FTYCityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //        self.didSelected = NO;
        
        UIImageView *accessView = [[UIImageView alloc] init];
        accessView.image = [UIImage imageNamed:AREA_SELECT_CITY_IMG_NORMAL];
        self.accessView = accessView;
        accessView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:accessView];
        
        
        UIView *viewContent = [[UIView alloc] init];
        [viewContent setBackgroundColor:[UIColor whiteColor]];
        self.viewContent = viewContent;
        
        UILabel *lblCity = [[UILabel alloc] init];
        self.titleLable = lblCity;
        [lblCity setFont:[UIFont systemFontOfSize:15]];
        [lblCity setTextColor:[UIColor blackColor]];
        [viewContent addSubview:lblCity];
        [self.contentView addSubview:viewContent];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat rightMargin = 5;
    CGFloat accessViewW = 30;
    CGFloat accessViewX = self.frame.size.width- accessViewW - rightMargin;
    CGFloat accessViewH = self.frame.size.height;
    CGFloat accessViewY = 0;
    
    self.accessView.frame = CGRectMake(accessViewX, accessViewY, accessViewW, accessViewH);
    self.viewContent.frame = CGRectMake(0, 0, self.frame.size.width - 60, 44);
    self.titleLable.frame = CGRectMake(15, 0, self.frame.size.width - 60, 44);
    
}

- (void)setShowRightImageView:(BOOL)showRightImageView{
    
    _showRightImageView = showRightImageView;
    if (showRightImageView) {
        self.accessView.image = [UIImage imageNamed:AREA_SELECT_CITY_IMG_SELECTED];
    } else {
        self.accessView.image = [UIImage imageNamed:AREA_SELECT_CITY_IMG_NORMAL];
    }
}


- (void)setCity:(FTYCityModel *)city{
    
    _city = city;
    
    self.titleLable.text = city.name;
    
    
}

@end
