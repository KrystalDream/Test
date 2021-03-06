//
//  STPickerDate.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerDate.h"
#import "NSCalendar+ST.h"
@interface STPickerDate()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.年 */
@property (nonatomic, assign)NSInteger year;
/** 2.月 */
@property (nonatomic, assign)NSInteger month;
/** 3.日 */
@property (nonatomic, assign)NSInteger day;

@property (nonatomic, assign) NSInteger column;

@end

@implementation STPickerDate

#pragma mark - --- init 视图初始化 ---

- (void)setupUI {
    /*
     @property(null_resettable, nonatomic,strong) UIColor  *borderButtonColor;
     @property(null_resettable, nonatomic,strong) UIColor  *leftButtonTilteColor;
     @property(null_resettable, nonatomic,strong) UIColor  *rightButtonTilteColor;
     */
    
    self.title = @"请选择日期";
    self.borderButtonColor = [UIColor clearColor];
    self.leftButtonTilteColor = [UIColor lightGrayColor];
    self.rightButtonTilteColor = [UIColor lightGrayColor];

    _yearLeast = 1900;
    _yearSum   = 200;
    _heightPickerComponent = 28;
    
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
    
    _column = 3;
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
    [self.pickerView selectRow:(_year - _yearLeast) inComponent:0 animated:NO];
    [self.pickerView selectRow:(_month - 1) inComponent:1 animated:NO];
    if (_column) {
         [self.pickerView selectRow:(_day - 1) inComponent:2 animated:NO];
    }
   

}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _column;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearSum;
    }else if(component == 1) {
        return 12;
    }else {
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.yearLeast;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        return  [NSCalendar getDaysWithYear:yearSelected month:monthSelected];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            break;
        case 1:
            [pickerView reloadComponent:2];
        default:
            break;
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%zd", row + 1900];
    }else if (component == 1){
        text =  [NSString stringWithFormat:@"%zd", row + 1];
    }else{
        text = [NSString stringWithFormat:@"%zd", row + 1];
    }

    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    if ([self.delegate respondsToSelector:@selector(pickerDate:year:month:day:)]) {
         [self.delegate pickerDate:self year:self.year month:self.month day:self.day];
    }
   
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    self.year  = [self.pickerView selectedRowInComponent:0] + self.yearLeast;
    self.month = [self.pickerView selectedRowInComponent:1] + 1;
    if (_column > 2) {
        self.day   = [self.pickerView selectedRowInComponent:2] + 1;
    }
    
}

#pragma mark - --- setters 属性 ---

- (void)setYearLeast:(NSInteger)yearLeast
{
    _yearLeast = yearLeast;
}

- (void)setYearSum:(NSInteger)yearSum
{
    _yearSum = yearSum;
}

- (void)setPickerTitle:(NSString *)pickerTitle {
    _pickerTitle = pickerTitle;
    self.title = pickerTitle;
}
#pragma mark - --- getters 属性 ---

@end


