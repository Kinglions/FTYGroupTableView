//
//  FTYTypeView.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "FTYTypeView.h"
#import "FTYTypeModel.h"
#import "FTYTypeTableViewCell.h"

@interface FTYTypeView () <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) UITableView *typeTableView;


@end

@implementation FTYTypeView

- (void)setPlistName:(NSString *)plistName{
    NSRange range = [plistName rangeOfString:@".plist"];
    if (range.location == NSNotFound) { // 不包含
        plistName = [NSString stringWithFormat:@"%@%@", plistName, @".plist"];
    }
    _plistName = [plistName copy];
}

- (NSArray *)types{

    if (_types == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.plistName ofType:@""];
        NSArray *typeArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *typesM = [NSMutableArray array];
        for (NSDictionary *dict in typeArray) {
            FTYTypeModel *type = [FTYTypeModel typeWithDict:dict];
            [typesM addObject:type];
        }
        _types = typesM;
    }
    return _types;
}

- (instancetype)init{
    
    if (self = [super init]) {
        UITableView *typeTableView = [[UITableView alloc] init];
        typeTableView.dataSource = self;
        typeTableView.delegate = self;
        self.typeTableView = typeTableView;
        [self addSubview:typeTableView];
        
        self.arrSelectedRow = [NSMutableArray array];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame{
//    
//    [super setFrame:frame];
//    _width = self.frame.size.width;
//    _height = self.frame.size.height;
//    [self setNeedsLayout];
//}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.typeTableView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.types.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FTYTypeTableViewCell *cell = [FTYTypeTableViewCell cellWithTableView:tableView];
    cell.type = self.types[indexPath.row];
    
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
    [self.typeTableView reloadData];
}

#pragma mark - 共有方法
- (void)reloadData{
    
    [self.typeTableView reloadData];
}

@end
