//
//  FTYStageView.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "FTYStageView.h"
#import "FTYStageModel.h"
#import "FTYStageTableViewCell.h"

@interface FTYStageView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *stageTableView;

@end

@implementation FTYStageView

- (void)setPlistName:(NSString *)plistName{
    NSRange range = [plistName rangeOfString:@".plist"];
    if (range.location == NSNotFound) { // 不包含
        plistName = [NSString stringWithFormat:@"%@%@", plistName, @".plist"];
    }
    _plistName = [plistName copy];
}


- (NSArray *)stages{
    if (_stages == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.plistName ofType:@""];
        NSArray *stageArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *stagesM = [NSMutableArray array];
        for (NSDictionary *dict in stageArray) {
            FTYStageModel *stage = [FTYStageModel stageWithDict:dict];
            [stagesM addObject:stage];
        }
        _stages = stagesM;
    }
    return _stages;
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        UITableView *stageTableView = [[UITableView alloc] init];
        stageTableView.delegate = self;
        stageTableView.dataSource = self;
        self.stageTableView = stageTableView;
        [self addSubview:stageTableView];
        
        self.arrSelectedRow = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.stageTableView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.stages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FTYStageTableViewCell *cell = [FTYStageTableViewCell cellWithTableView:tableView];
    
    cell.stage = self.stages[indexPath.row];
    
    if ([self.arrSelectedRow containsObject:@(indexPath.row)]) {
        cell.showLeftImageView = YES;
    } else {
        cell.showLeftImageView = NO;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.arrSelectedRow containsObject:@(indexPath.row)]) {
        [self.arrSelectedRow removeObject:@(indexPath.row)];
    } else {
        [self.arrSelectedRow addObject:@(indexPath.row)];
    }
    
    [self.stageTableView reloadData];
}

#pragma mark - 共有方法
- (void)reloadData{
    
    [self.stageTableView reloadData];
}


@end
