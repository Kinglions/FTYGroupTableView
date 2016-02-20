//
//  FTYTypeTableViewCell.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTYTypeModel;
@interface FTYTypeTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) FTYTypeModel *type;
/**
 *  是否显示左边指示图片
 */
@property (assign, nonatomic, getter=iSshowLeftImageView) BOOL showLeftImageView;
@end
