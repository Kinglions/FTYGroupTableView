//
//  FTYMainView.h
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTYMainView : UIView
/**
 *  全国省份文件名
 */
@property (copy, nonatomic) NSString *areaNoPlistName;
/**
 *  阶段文件名
 */
@property (copy, nonatomic) NSString *stageNoPlistName;
/**
 *  类型文件名
 */
@property (copy, nonatomic) NSString *typeNoPlistName;
@end
