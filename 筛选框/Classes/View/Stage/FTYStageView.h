//
//  FTYStageView.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTYStageView : UIView
@property (strong, nonatomic) NSMutableArray *arrSelectedRow;
/**
 *  刷新表格
 */
- (void)reloadData;
/**
 *  阶段文件名称
 */
@property (copy, nonatomic) NSString *plistName;
/**
 *  阶段模型数组
 */
@property (strong, nonatomic) NSArray *stages;
@end
