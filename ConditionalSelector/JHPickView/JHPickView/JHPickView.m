//
//  JHPickView.m
//  SmallCityStory
//
//  Created by Jivan on 2017/5/8.
//  Copyright © 2017年 leleyinhangjia. All rights reserved.
//
//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

//字体大小
#define kfont 15

#import "JHPickView.h"
#import "CityModelData.h"
#import "MySingleton.h"
#import <Masonry.h>
@interface JHPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIView *bgV;

@property (nonatomic,strong)UIButton *cancelBtn;

@property (nonatomic,strong)UIButton *conpleteBtn;


@property (nonatomic,strong)UIPickerView *pickerV;


@property (nonatomic,strong)NSMutableArray *array;

@property (nonatomic,strong) UIView* line ;
/**
 *  所有的省份
 */
@property (nonatomic,strong)NSMutableArray *allProvince;
/**
 *  选中的省份对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithProvince;
/**
 *  选中的市级对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithCity;
/**
 *  选中的县级对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithTown;
/**
 *  城市模型数据
 */
@property (nonatomic,strong)CityModelData  *cityModel;
//日期选择
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation JHPickView

-(NSMutableArray *)allProvince{
    if (_allProvince==nil) {
        
        _allProvince= (NSMutableArray *)self.cityModel.province ;
    }
    return _allProvince;
}

-(CityModelData *)cityModel{
    
    if (_cityModel==nil) {
        MySingleton *mySing=[MySingleton shareMySingleton];
        if (mySing.cityModel) {
            _cityModel=mySing.cityModel;
        }
        else{
            NSString *jsonPath=[[NSBundle mainBundle]pathForResource:@"province_data.json" ofType:nil];
            NSData *jsonData=[[NSData alloc]initWithContentsOfFile:jsonPath];
            NSString *stringValue=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSDictionary *dicValue=[mySing getObjectFromJsonString:stringValue];  // 将本地JSON数据转为对象
            _cityModel=[CityModelData mj_objectWithKeyValues:dicValue];
            mySing.cityModel=_cityModel;
        }
    }
    return _cityModel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.array = [NSMutableArray array];
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = RGBA(51, 51, 51, 0.8);
        self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260*hScale)];
        self.bgV.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgV];
        
        [self showAnimation];
        //取消
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(44);
            
        }];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitleColor:[UIColor colorWithRed:1.00f green:0.59f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
        //完成
        self.conpleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:self.conpleteBtn];
        [self.conpleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(44);
            
        }];
        self.conpleteBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.conpleteBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.conpleteBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.conpleteBtn setTitleColor:[UIColor colorWithRed:1.00f green:0.59f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
        
        //选择titi
        self.selectLb = [UILabel new];
        [self.bgV addSubview:self.selectLb];
        [self.selectLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.bgV.mas_centerX).offset(0);
            make.centerY.mas_equalTo(self.conpleteBtn.mas_centerY).offset(0);
            
        }];
        self.selectLb.font = [UIFont systemFontOfSize:kfont];
        self.selectLb.textAlignment = NSTextAlignmentCenter;
        
        //线
        UIView *line = [UIView new];
        [self.bgV addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(self.cancelBtn.mas_top).offset(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(0.5);
            
        }];
        line.backgroundColor = RGBA(224, 224, 224, 1);
        self.line = line ;
        
    }
    return self;
}


#pragma mark - setter、getter
- (void)setSelectDate:(NSString *)selectDate {
    
    [_datePicker setDate:[self.formatter dateFromString:selectDate] animated:YES];
}
- (NSDateFormatter *)formatter {
    if (_formatter) {
        return _formatter;
    }
    _formatter =[[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy年MM月d日"];
    return _formatter;
    
}
- (void)setCustomArr:(NSArray *)customArr{
    
    //选择器
    self.pickerV = [UIPickerView new];
    [self.bgV addSubview:self.pickerV];
    [self.pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_line);
        make.top.mas_equalTo(self.bgV);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        
    }];
    self.pickerV.delegate = self;
    self.pickerV.dataSource = self;
    
    
    _customArr = customArr;
    [self.array addObject:customArr];

    
}

- (void)setArrayType:(ARRAYTYPE)arrayType
{
    _arrayType = arrayType;
    
    if (self.arrayType == DeteArray) {
        //选择器
        self.datePicker = [UIDatePicker new];
        [self.bgV addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(_line);
            make.top.mas_equalTo(self.bgV);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        
        //日期
        [_datePicker setDate:[NSDate date] animated:YES];
        [_datePicker setMaximumDate:[NSDate date]];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        
        [_datePicker setMinimumDate:[self.formatter dateFromString:@"1900年1月1日"]] ;
        
    }else{
        //选择器
        self.pickerV = [UIPickerView new];
        [self.bgV addSubview:self.pickerV];
        [self.pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(_line);
            make.top.mas_equalTo(self.bgV);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        self.pickerV.delegate = self;
        self.pickerV.dataSource = self;
        
    }
    switch (arrayType) {
            
            
        case GenderArray:
        {
            self.selectLb.text = @"选择性别";
            [self.array addObject:@[@"男",@"女"]];
        }
            break;
            /** 自定义职业 */
        case ProfessionArray:
        {
            self.selectLb.text = @"选择职业";
            NSArray *arr = @[@"在校学生",@"军人",@"私人业主",@"企业员工",@"政府机关/事业单位",@"其他"];
            [self.array addObject:arr];
        }
            break;
            
            /** 自定义收入 */
        case TakeInArray:
        {
            self.selectLb.text = @"选择收入";
            NSArray *arr = @[@"小于2000",@"2000-5000",@"5000-10000",@"10000-20000",@"20000以上"];
            [self.array addObject:arr];
        }
            break;
            /** 自定义教育 */
        case EducationArray:
        {
            self.selectLb.text = @"选择收入";
            NSArray *arr = @[@"小于2000",@"2000-5000",@"5000-10000",@"10000-20000",@"20000以上"];
            [self.array addObject:arr];
        }
            break;
            /** 年龄 */
        case AgeArray:
        {
            self.selectLb.text = @"选择年龄";
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 20; i <= 80; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d 岁",i];
                [arr addObject:str];
            }
            [self.array addObject:(NSArray *)arr];
        }
            break;
            
        case HeightArray:
        {
            self.selectLb.text = @"选择身高";
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 100; i <= 250; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d cm",i];
                [arr addObject:str];
            }
            [self.array addObject:(NSArray *)arr];
        }
            break;
        case weightArray:
        {
            self.selectLb.text = @"选择体重";
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 30; i <= 200; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d kg",i];
                [arr addObject:str];
            }
            [self.array addObject:(NSArray *)arr];
        }
            break;
        case DeteArray:
        {
            self.selectLb.text = @"选择出生年月";
        }
            break;
            
          case AreaArray:
        {
            self.selectLb.text = @"选择省市区";
            [self getAreaData];
        }
            break ;
        default:
            break;
    }
}

-(void)getAreaData
{
    self.array = self.allProvince ; 
}



#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (self.arrayType == AreaArray) {
        return  3 ;
    }else{
       return self.array.count;
    }
    
   
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    
    if (self.arrayType == AreaArray) {
        
        Province *province=self.allProvince[self.selectRowWithProvince];
        City *city=province.city[self.selectRowWithCity];
        if (component==0) return self.allProvince.count;
        if (component==1) return province.city.count;
        if (component==2) return city.district.count;
        return 0;

    }
    else{
        
        return arr.count;
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return label;
    
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.arrayType == AreaArray) {
        if (component==0) {                    // 只有点击了第一列才去刷新第二个列对应的数据
            self.selectRowWithProvince=row;   //  刷新的下标
            self.selectRowWithCity=0;
            [pickerView reloadComponent:1];  //   刷新第一,二列
            [pickerView reloadComponent:2];
        }
        else if(component==1){
            self.selectRowWithCity=row;       //  选中的市级的下标
            [pickerView reloadComponent:2];  //   刷新第三列
        }
        else if(component==2){
            self.selectRowWithTown=row;
        }

    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (self.arrayType == AreaArray) {
        NSString *showTitleValue=@"";
        if (component==0){
            Province *province=self.allProvince[row];
            showTitleValue=province.name;
        }
        if (component==1){
            Province *province=self.allProvince[self.selectRowWithProvince];
            City *city=province.city[row];
            showTitleValue=city.name;
        }
        if (component==2) {
            Province *province=self.allProvince[self.selectRowWithProvince];
            City *city=province.city[self.selectRowWithCity];
            District *dictrictObj=city.district[row];
            showTitleValue=dictrictObj.name;
        }
        return showTitleValue;

    }else{
        
        NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
        return [arr objectAtIndex:row % arr.count];
    }
  
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    if ( self.arrayType == AreaArray) {
        
        return (ScreenWidth - 30)/3.0;
        
    }else{
        
        return (ScreenWidth - 30);
    }
    
}

#pragma mark-----点击方法

- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}

- (void)completeBtnClick{
    
    NSString *fullStr = [NSString string];
    
    for (int i = 0; i < self.array.count; i++) {
        
        NSArray *arr = [self.array objectAtIndex:i];
        
               if (self.arrayType == AreaArray) {
            
            fullStr = [self finaSureCity];
        }
        else{
            
            NSString *str = [arr objectAtIndex:[self.pickerV selectedRowInComponent:i]];
            fullStr = [fullStr stringByAppendingString:str];
        }
        
    }
    
    if (self.arrayType == DeteArray) {
        
           fullStr   =  [self.formatter stringFromDate:_datePicker.date] ;
       }

    
    if (_delegate && [_delegate respondsToSelector:@selector(PickerSelectorIndixString:)]) {
        
        [self.delegate PickerSelectorIndixString:fullStr];
    }
   
    
    [self hideAnimation];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}

#pragma mark 拼接最终的值
-(NSString *)finaSureCity{
    
    NSString *linkString;
    if (self.selectRowWithProvince<self.allProvince.count) {
        Province *provinceValue=self.allProvince[self.selectRowWithProvince];
        if (self.selectRowWithCity<provinceValue.city.count) {
            City *cityValue=provinceValue.city[self.selectRowWithCity];
            if (self.selectRowWithTown<cityValue.district.count) {
                District *dictrict=cityValue.district[self.selectRowWithTown];
                linkString=[NSString stringWithFormat:@"%@ %@ %@",provinceValue.name,cityValue.name,dictrict.name];
             
            }
        }
    }
    return linkString;
}
//隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = ScreenHeight;
        self.bgV.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self.bgV removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
}

//显示动画
- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = ScreenHeight-260*hScale;
        self.bgV.frame = frame;
    }];
    
}


@end






