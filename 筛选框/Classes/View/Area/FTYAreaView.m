//
//  FTYAreaView.m
//  筛选框
//
//  Created by FTY on 16/2/16.
//  Copyright © 2016年 FTY. All rights reserved.
//


#define UIColorFromRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define LINECOLOR   UIColorFromRGB16(0xcccccc)

#define TGSystemFontContent         [UIFont systemFontOfSize:14]//内容

#define TextProvince    @"省份"
#define Textcity        @"城市"

// tableView的tag值（用来区分两个tableView）
#define TAG_PROVINCE    100
#define TAG_CITY        101

#define PROVINCE_WIDTH  100

// 指示view的图片
#define AREA_SELECT_CITY_IMG_NORMAL             @"center_checkbox_normal"
#define AREA_SELECT_CITY_IMG_SELECTED           @"center_checkbox_selected"


#define AREA_SELECT_PROVINCE_IMG_NORMAL         @"project_area_province_normal"
#define AREA_SELECT_PROVINCE_IMG_HIGHLIGHT      @"project_area_province_highlight"
#define AREA_SELECT_PROVINCE_IMG_ALERT          @"project_province_selected"


#import "FTYAreaView.h"

#import "FTYCityTableViewCell.h"
#import "FTYProvinceTableViewCell.h"

#import "FTYCityModel.h"
#import "FTYProvinceModel.h"


@interface FTYAreaView()<UITableViewDataSource, UITableViewDelegate>

typedef void (^NSDictionaryBlock)(NSDictionary *dic);
/**
 *  省份的tableView
 */
@property (nonatomic, weak) UITableView *provinceTableView;
/**
 *  城市的tableView
 */
@property (weak, nonatomic) UITableView *cityTableView;

/**
 *  是否选中省份
 *  0   选中第一行
 *  非0 选中其他行
 */
@property (assign, nonatomic) NSInteger isSelectProvince;


@property (nonatomic,copy) NSDictionaryBlock singleChooceBlock;

@property (strong, nonatomic) NSDictionary *dicArea;
@property (assign, nonatomic) BOOL isSelectLocationArea;

@property (assign, nonatomic) NSInteger rowLocationArea;



@property (nonatomic,assign,readonly)CGFloat width;

@property (nonatomic,assign,readonly)CGFloat height;

@property (strong, nonatomic) NSMutableArray *arrSelectedCityRow;
@property (strong, nonatomic) NSMutableArray *arrSelectedProvinceRow;

@end

@implementation FTYAreaView


- (void)setPlistName:(NSString *)plistName{
    NSRange range = [plistName rangeOfString:@".plist"];
    if (range.location == NSNotFound) { // 不包含
        plistName = [NSString stringWithFormat:@"%@%@", plistName, @".plist"];
    }
    _plistName = [plistName copy];
    
    // 路径
    NSString *path = [[NSBundle mainBundle] pathForResource:_plistName ofType:@""];
    NSArray *provinceArr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *provincesM = [NSMutableArray array];
    for (NSDictionary *dict in provinceArr) {
        FTYProvinceModel *provinceModel = [FTYProvinceModel provinceModelWithDict:dict];
        [provincesM addObject:provinceModel];
    }
    _provinces = provincesM;
}


- (instancetype)init{
    
    if (self = [super init]) {
        
        // 初始化全局变量
        self.rowLocationArea = -1;
        self.dicSelect = [[NSMutableDictionary alloc] init];
        self.isSelectProvince = 0;
        self.arrSelectedCityRow = [NSMutableArray array];
        self.arrSelectedProvinceRow = [NSMutableArray array];
        
        // 初始化省份表格
        [self setupProvinceTableView];
        
        // 初始化城市表格
        [self setupCityTableView];
    }
    return self;
}
/**
 *  初始化省份表格
 */
- (void)setupProvinceTableView{
    
    UITableView *provinceView = [[UITableView alloc] init];
    provinceView.dataSource = self;
    provinceView.delegate = self;
    provinceView.tag = TAG_PROVINCE;
    
    self.provinceTableView = provinceView;
    
    // 头部view
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PROVINCE_WIDTH, 44)];
    [viewHead setBackgroundColor:UIColorFromRGB16(0xf5f5f5)];
    [provinceView setTableHeaderView:viewHead];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 44)];
    [lbl setText:TextProvince];
    [lbl setBackgroundColor:UIColorFromRGB16(0xf5f5f5)];
    [lbl setFont:TGSystemFontContent];
    [viewHead addSubview:lbl];
    
    UILabel *lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, PROVINCE_WIDTH, 1)];
    [lblLine2 setBackgroundColor:LINECOLOR];
    [viewHead addSubview:lblLine2];
    
    UILabel *lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(99, 0, 1, 44)];
    [lblLine1 setBackgroundColor:LINECOLOR];
    [viewHead addSubview:lblLine1];
    
    [self addSubview:provinceView];
    
}
/**
 *  初始化城市表格
 */
- (void)setupCityTableView{
    
    UITableView *cictyView = [[UITableView alloc] init];
    cictyView.dataSource = self;
    cictyView.delegate = self;
    cictyView.tag = TAG_CITY;
    self.cityTableView = cictyView;
    
    // 底部view
    cictyView.tableFooterView = [[UIView alloc] init];
    
    // 头部view
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PROVINCE_WIDTH, 44)];
    [viewHead setBackgroundColor:UIColorFromRGB16(0xf5f5f5)];
    [cictyView setTableHeaderView:viewHead];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
    [lbl setText:Textcity];
    [lbl setBackgroundColor:UIColorFromRGB16(0xf5f5f5)];
    [lbl setFont:TGSystemFontContent];
    [viewHead addSubview:lbl];
    
    UILabel *lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, self.width - PROVINCE_WIDTH, 1)];
    [lblLine2 setBackgroundColor:[UIColor redColor]];
    [viewHead addSubview:lblLine2];
    
    
    
    [self addSubview:cictyView];
}
/**
 *  赋值给宽度和高度
 */
- (void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    _width = self.frame.size.width;
    _height = self.frame.size.height;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.provinceTableView.frame = CGRectMake(0, 0, PROVINCE_WIDTH, self.height);
    self.cityTableView.frame = CGRectMake(PROVINCE_WIDTH, 0, self.width-PROVINCE_WIDTH, self.height);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (tableView.tag) {
            // 省份
        case TAG_PROVINCE:
            return self.provinces.count;
            break;
            
            // 城市
        case TAG_CITY:
        {
            // 当前选中省份的城市
            FTYProvinceModel *province = self.provinces[self.isSelectProvince];
            return province.children.count;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (tableView.tag) {
        case TAG_PROVINCE:
        {
            // 创建cell
            FTYProvinceTableViewCell *cell = [FTYProvinceTableViewCell cellWithTableView:tableView];
            
            // 传递数据模型
            FTYProvinceModel *province = self.provinces[indexPath.row];
            cell.province = province;
            
            // 是否显示背景图片
            self.isSelectProvince == indexPath.row ? (cell.showImageViewBG = YES) : (cell.showImageViewBG = NO);
            
            BOOL isSelect = NO;
            for (NSNumber *numRow in self.dicSelect.keyEnumerator) {
                if([numRow integerValue] == indexPath.row && [[self.dicSelect objectForKey:numRow] count] > 0){
                    isSelect = YES;
                    break;
                }
            }
            // 是否显示左边指示图片
            isSelect ? (cell.showLeftImageView = YES) : (cell.showLeftImageView = NO);
            
            return cell;
        }
            break;
        case TAG_CITY:
        {
            
            // 创建cell
            FTYCityTableViewCell *cell = [FTYCityTableViewCell cellWithTableView:tableView];
            FTYProvinceModel *province = self.provinces[self.isSelectProvince];
            if (indexPath.row == 0) {
                cell.titleLable.text = [NSString stringWithFormat:@"%@所有城市", province.name];
            } else {
                cell.city = province.children[indexPath.row-1];
                
            }
            
            BOOL isSelect = NO;
            NSNumber *rowProvince = [NSNumber numberWithInteger:self.isSelectProvince];
            NSNumber *rowCity = [NSNumber numberWithInteger:indexPath.row];
            
            NSMutableArray *arrNum = [self.dicSelect objectForKey:rowProvince];
            if ([arrNum containsObject:rowCity] || [arrNum containsObject:[NSNumber numberWithInteger:0]] || isSelect) {
                cell.showRightImageView = YES;
            } else {
                cell.showRightImageView = NO;
            }
            
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
    
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (tableView.tag) {
        case TAG_PROVINCE:{
            self.isSelectProvince = indexPath.row;
            [self.provinceTableView reloadData];
            [self.cityTableView reloadData];
            break;
        }
        case TAG_CITY:{
            if(_singleChooceBlock){
                NSMutableArray *arrNum = [[NSMutableArray alloc] init];
                _dicSelect = [[NSMutableDictionary alloc] init];
                [arrNum addObject:[NSNumber numberWithInteger:indexPath.row]];
                [_dicSelect setObject:arrNum forKey:[NSNumber numberWithInteger:self.isSelectProvince]];
                [self.provinceTableView reloadData];
                [self.cityTableView reloadData];
                _singleChooceBlock(_dicSelect);
                return;
                
            }
            
            
            NSNumber *rowProvince = [NSNumber numberWithInteger:self.isSelectProvince];
            NSNumber *rowCity = [NSNumber numberWithInteger:indexPath.row];
            
            FTYProvinceModel *province = self.provinces[self.isSelectProvince];
            NSArray *arrCity = province.children;
            BOOL isLocation = NO;
            
            if(self.dicArea
               && [self.dicArea objectForKey:province.no]
               && [[self.dicArea objectForKey:province.no] length] == 12
               && [[[self.dicArea objectForKey:province.no] substringToIndex:8] isEqualToString:province.no]){
                isLocation = YES;
            }
            NSMutableArray *arrNum = [self.dicSelect objectForKey:rowProvince];
            if(arrNum == nil){
                arrNum = [[NSMutableArray alloc] init];
            }
            if(isLocation && indexPath.row != 0 && indexPath.row != 1){
                rowCity = [NSNumber numberWithInteger:indexPath.row - 1];
            }
            
            
            if([arrNum containsObject:rowCity]){
                [arrNum removeObject:rowCity];
                if(isLocation){
                    if(indexPath.row == 1 || indexPath.row == self.rowLocationArea || indexPath.row == 0){
                        self.isSelectLocationArea = NO;
                        [arrNum removeObject:[NSNumber numberWithInteger:1]];
                        [arrNum removeObject:[NSNumber numberWithInteger:self.rowLocationArea - 1]];
                    }
                    
                }
            }
            else if(![arrNum containsObject:[NSNumber numberWithInteger:0]]){
                if(indexPath.row == 0){
                    [arrNum removeAllObjects];
                }
                [arrNum addObject:rowCity];
                if(arrNum.count == arrCity.count){
                    [arrNum removeAllObjects];
                    [arrNum addObject:[NSNumber numberWithInteger:0]];
                    if(isLocation){
                        self.isSelectLocationArea = YES;
                    }
                }
                else{
                    if(isLocation){
                        if(indexPath.row == 1 || indexPath.row == self.rowLocationArea || indexPath.row == 0){
                            self.isSelectLocationArea = YES;
                            if(indexPath.row == 1){
                                [arrNum removeObject:rowCity];
                                [arrNum addObject:[NSNumber numberWithInteger:self.rowLocationArea - 1]];
                            }
                        }
                        
                    }
                }
                
            }
            else{
                [arrNum removeObject:[NSNumber numberWithInteger:0]];
                for (int i = 1; i <= arrCity.count; i++) {
                    [arrNum addObject:[NSNumber numberWithInteger:i]];
                }
                if(isLocation){
                    if(indexPath.row == 1 || self.rowLocationArea == indexPath.row){
                        self.isSelectLocationArea = NO;
                        [arrNum removeObject:[NSNumber numberWithInteger:self.rowLocationArea - 1]];
                    }
                    else{
                        [arrNum removeObject:[NSNumber numberWithInteger:indexPath.row - 1]];
                    }
                }
                else{
                    [arrNum removeObject:[NSNumber numberWithInteger:indexPath.row]];
                }
            }
            
            [self.dicSelect setObject:arrNum forKey:[NSNumber numberWithInteger:self.isSelectProvince]];
            [self.provinceTableView reloadData];
            [self.cityTableView reloadData];
            break;
        }
        default:
            break;
    }
    
    
    
}


#pragma mark - 共有方法
- (void)reloadData{
    [self.provinceTableView reloadData];
    [self.cityTableView reloadData];
}

- (void)reloadTblist{
    for (NSNumber *key in _dicSelect.keyEnumerator) {
        _isSelectProvince = [key integerValue];
        break;
    }
    [_provinceTableView reloadData];
    [_cityTableView reloadData];
}

- (void)setDicSelect:(NSMutableDictionary *)dicSelect{
    _dicSelect = dicSelect;
    [self reloadTblist];
}



@end
