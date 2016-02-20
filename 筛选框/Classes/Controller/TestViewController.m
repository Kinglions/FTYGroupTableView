//
//  TestViewController.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "TestViewController.h"
#import "FTYMainView.h"

@implementation TestViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    FTYMainView *mainView = [[FTYMainView alloc] init];
    mainView.areaNoPlistName = @"areaNo";
    mainView.typeNoPlistName = @"typeNo";
    mainView.stageNoPlistName = @"stageNo";
    mainView.frame = self.view.bounds;
    [self.view addSubview:mainView];
}

@end
