//
//  FTYAreaView.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//  一个view包装两个tableView

#import <UIKit/UIKit.h>

@interface FTYAreaView : UIView
/**
 *  省份城市选中
 */
@property (nonatomic,strong) NSMutableDictionary *dicSelect;
/**
 *  刷新表格
 */
- (void)reloadData;
/**
 *  省份文件名
 */
@property (copy, nonatomic) NSString *plistName;
/**
 *  身份模型数组
 */
@property (strong, nonatomic) NSArray *provinces;
@end
