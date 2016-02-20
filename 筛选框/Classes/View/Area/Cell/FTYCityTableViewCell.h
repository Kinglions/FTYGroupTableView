//
//  FTYCityTableViewCell.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTYCityModel;
@interface FTYCityTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  城市模型
 */
@property (strong, nonatomic) FTYCityModel *city;
/**
 *  是否显示右边指示图片
 */
@property (assign, nonatomic, getter=iSshowRightImageView) BOOL showRightImageView;
/**
 *  title内容
 */
@property (weak, nonatomic) UILabel *titleLable;
@end
