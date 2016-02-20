//
//  FTYProvinceTableViewCell.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTYProvinceModel;
@interface FTYProvinceTableViewCell : UITableViewCell
/**
 *  省份模型
 */
@property (strong, nonatomic) FTYProvinceModel *province;
/**
 *  快速创建cell
 *
 *  @param tableView tableView
 *
 *  @return 自定义cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


/**
 *  是否显示背景图片
 */
@property (assign, nonatomic, getter=iSshowImageViewBG) BOOL showImageViewBG;
/**
 *  是否显示左边指示图片
 */
@property (assign, nonatomic, getter=iSshowLeftImageView) BOOL showLeftImageView;
@end
