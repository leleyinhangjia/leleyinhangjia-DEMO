//
//  ViewController.m
//  JHPickView
//
//  Created by leleyinhangjia on 2017/5/13.
//  Copyright © 2017年 leleyinhangjia. All rights reserved.
//

#import "ViewController.h"
#import "JHPickView.h"

#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,JHPickerDelegate>


@property (strong,nonatomic) UITableView* tableView ;
@property (strong,nonatomic) NSArray* cellTiltleArr ;
@property (assign,nonatomic) NSIndexPath* selectedIndexPath ;

@end

@implementation ViewController

-(NSArray*)cellTiltleArr
{
    if (!_cellTiltleArr) {
        
        _cellTiltleArr = @[@"性别",@"职业",@"收入",@"生日",@"现居地",@"身高",@"体重",@"情感状态",@"年龄"];
    }
    
    return _cellTiltleArr ;
}
-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        [self.view  addSubview: _tableView];
    }
    
    return _tableView ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.hidden = NO ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath ;
    
   if (indexPath.row == 0) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = GenderArray;
        [self.view addSubview:picker];
        
    }
    if (indexPath.row == 1) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = ProfessionArray;
        [self.view addSubview:picker];
        
    }
    if (indexPath.row == 2) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = TakeInArray;
        [self.view addSubview:picker];
        
    }
    
    if (indexPath.row == 3) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = DeteArray;
        [self.view addSubview:picker];
    }
    
    if (indexPath.row == 4) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = AreaArray;
        [self.view addSubview:picker];
    }
    if (indexPath.row == 5) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = HeightArray;
        [self.view addSubview:picker];
    }
    
    if (indexPath.row == 6) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = weightArray;
        [self.view addSubview:picker];
    }
    
    if (indexPath.row == 7) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.selectLb.text = @"情感状态";
        picker.customArr = @[@"已婚",@"未婚",@"保密"];
        [self.view addSubview:picker];
    }
    if (indexPath.row == 8) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = AgeArray;
        [self.view addSubview:picker];
    }
}

#pragma mark - JHPickerDelegate

-(void)PickerSelectorIndixString:(NSString *)str
{
    
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath] ;
    cell.detailTextLabel.text = str ;
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
    if (self.selectedIndexPath.row == 1) {
        
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellTiltleArr.count ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"cellID" ;
    UITableViewCell*  cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
    
    for (UIView* View in cell.contentView.subviews)
    {
        if ([View isKindOfClass:[UIImageView class]]||[View isKindOfClass:[UITextField class]]) {
            [View removeFromSuperview];
        }
        
    }
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        
    }
    
    cell.textLabel.text = self.cellTiltleArr[indexPath.row];
   
    return cell ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
