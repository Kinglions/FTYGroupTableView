//
//  FTYTypeView.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTYTypeView : UIView
/**
 *  选中的类型
 */
@property (strong, nonatomic) NSMutableArray *arrSelectedRow;
/**
 *  刷新表格
 */
- (void)reloadData;
/**
 *  类型模型数组
 */
@property (strong, nonatomic) NSArray *types;
/**
 *  类型文件名
 */
@property (copy, nonatomic) NSString *plistName;
@end
