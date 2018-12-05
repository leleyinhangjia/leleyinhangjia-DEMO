//
//  LMSearchViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMSearchViewController.h"
#import "TokenTool.h"
#import "SearchListJsonHandler.h"
#import "SearchModel.h"
#import "SearchViewCell.h"
#define fontCOLOR [UIColor colorWithRed:163/255.0f green:163/255.0f blue:163/255.0f alpha:1]

@interface LMSearchViewController ()  <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,SearchListJsonHandlerDelegate,UIGestureRecognizerDelegate>
{
    SearchListJsonHandler *searchHandler;
}



/** 搜索文本框 */
@property (nonatomic, weak) LMSearchBar *search;
/** 历史搜索的tableView */
@property (nonatomic, strong) UITableView *historyTableView;
/** 搜索新闻/用户/公司的tableView */
//@property (nonatomic, strong) UITableView *newsTableView;

//@property (nonatomic, strong) UITableView *showTableView;


@property (nonatomic,strong)NSMutableArray * searchHistory;

@property (nonatomic,strong) NSArray *myArray;//搜索记录的数组

@property (nonatomic, strong) SearchData *dataModel;

/** 获取SearchData数组数据 */
@property (nonatomic, strong) NSMutableArray *searchArray;

/** 获取OrgModel数组数据 */
@property (nonatomic, strong) NSArray *orgArray;

/** 获取CompanyModel数组数据 */
@property (nonatomic, strong) NSArray *companyArray;

/** 获取UserModel2数组数据 */
@property (nonatomic, strong) NSArray *userArray;

@property (nonatomic, assign) BOOL isReload;

@end

@implementation LMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isReload = NO;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    searchHandler = [[SearchListJsonHandler alloc] init];
    searchHandler.delegate = self;
    
    
    _searchHistory = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化导航条内容
    [self setNavigationItem];
    
    //初始化UI
    [self setUI];
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    singleTap.numberOfTapsRequired = 1; // 单击
    [self.view addGestureRecognizer:singleTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
   
}
#pragma mark
#pragma mark - 单击手势方法
- (void)handleSingleTap{
     [self.search resignFirstResponder];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //文本框获取焦点
    [super viewDidAppear:animated];
    [self.search becomeFirstResponder];
    
}


- (void)setNavigationItem
{
    LMSearchBar *searchBar = [LMSearchBar searchBar];
    CGFloat w = self.view.width * 0.85;
    searchBar.frame = CGRectMake(0, 0, w, 30);
    searchBar.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.search = searchBar;
    
    //取消按钮
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:@"取消" titleColor:[UIColor whiteColor] target:self action:@selector(backClick)];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightItem,nil];

    /** 调整导航条上leftBarButtonItem和rightBarButtonItem与屏幕边界的间距
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-20时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */

    
}
- (void)setUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.historyTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.historyTableView.delegate = self;
    self.historyTableView.dataSource = self;
    self.historyTableView.separatorStyle = 0;
    [self.view addSubview:self.historyTableView];
    
}

- (void)backClick
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - SearchListJsonHandlerDelegate
- (void)SearchListJsonHandler:(SearchListJsonHandler *)handler withResult:(SearchData *)result {
    _dataModel = result;
//    NSLog(@"_dataModel---%@",_dataModel);
    _orgArray = _dataModel.org;
    _companyArray = _dataModel.company;
    _userArray = _dataModel.user;
    _isReload = YES;
    [self.historyTableView reloadData];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField  {
    [self readNSUserDefaults];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length < 1) {
        return;
    }
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"word"] = textField.text;
    [searchHandler handlerSearchObject:@"https://rong.36kr.com/api/mobi/search" params:params];
    
}

- (void)textFieldChanged:(NSNotification *)noti {
//    NSLog(@"%@",_search.text);
    //    NSLog(@"wordValue---!%@",wordValue);
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"word"] = _search.text;
    [searchHandler handlerSearchObject:@"https://rong.36kr.com/api/mobi/search" params:params];


}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self readNSUserDefaults];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{//搜索方法
    if (textField.text.length > 0) {
        // 缓存搜索记录, reload一次
        
        [TokenTool SearchText:textField.text];//缓存搜索记录
        [textField resignFirstResponder];
        
    }else{
        [textField resignFirstResponder];
    }
    
    return YES;
}




#pragma mark - UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!_isReload) {
        return 2;
    } else {
        int count = 0;
        if (_orgArray.count) {
            count++;
        }
        if (_companyArray.count) {
            count++;
        }
        if (_userArray.count) {
            count++;
        }
        NSLog(@"count!!%d",count+1);
        return count + 1;//
    }
//    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_isReload) {
    
        if (section==0) {
//            NSLog(@"section---%ld",section);
            if (_myArray.count>0) {
                return _myArray.count+1+1;
            }else{
                return 1;
            }
        }else{
            return 0;
        }

    } else {

        if (section == 0) {
            return 1;
        } else if (section == 1) {
            if (_dataModel.moreuser) {
                if (_userArray.count >= 3) {
                    return 4;
                }
                return _userArray.count + 1;
            }
            if (_dataModel.morecompany) {
                if (_companyArray.count >= 3) {
                    return 4;
                }
                return _companyArray.count + 1;
            }
            if (_orgArray.count) {
                if (_orgArray.count >= 3) {
                    return 4;
                }
                return _orgArray.count + 1;
            }
        } else if (section == 2){
            if (_dataModel.morecompany) {
                if (_companyArray.count >= 3) {
                    return 4;
                }
                return _companyArray.count + 1;
            }
            if (_orgArray.count) {
                if (_orgArray.count >= 3) {
                    return 4;
                }
                return _orgArray.count + 1;
            }
        }  else {
            if (_orgArray.count >= 3) {
                return 4;
            }
            return _orgArray.count + 1;
        }
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_isReload) {
        if (indexPath.section==0) {
            if(indexPath.row ==0){
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                //            cell.sepa
                if (_myArray.count == 0) {
                    return cell;
                }
                cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                //            cell.
                cell.textLabel.text = @"历史搜索";
                cell.textLabel.textColor = fontCOLOR;
                return cell;
            }else if (indexPath.row == _myArray.count+1){
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                cell.textLabel.text = @"清除历史记录";
                cell.textLabel.textColor = [UIColor blueColor];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                return cell;
            }else{
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
                NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
                cell.textLabel.text = reversedArray[indexPath.row-1];
                return cell;
            }
        }else{
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            return cell;
        }

    }  else {
        if(indexPath.section == 0){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"searchCell"];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"搜索新闻";
            cell.textLabel.textColor = fontCOLOR;
            return cell;
        }else if (indexPath.section ==  1){
            NSLog(@"indexPath.row---%ld",indexPath.row);
            if (_userArray.count < 1) {
                 UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"userCell"];
                return cell;
            }
            if (indexPath.row == 0) {
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:1 reuseIdentifier:@"userCell"];
                cell.textLabel.text = @"相关用户";
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.text = @"更多";
                cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
                cell.textLabel.textColor = fontCOLOR;
                return cell;
            }
            
            
            UserModel2 *userModel = _userArray[indexPath.row - 1];
            SearchViewCell *searchCell = [SearchViewCell cellWithTableView:tableView];
            searchCell.modelUser = userModel;
            /* 忽略点击效果 */
            [searchCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return searchCell;
        }else if (indexPath.section == 2){
            if (_companyArray.count < 1) {
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"companyCell"];
                return cell;
            }
            if (indexPath.row == 0) {
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:1 reuseIdentifier:@"companyCell"];
                cell.textLabel.text = @"创业公司";
                cell.detailTextLabel.text = @"更多";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = fontCOLOR;
                return cell;
                
            }
            
            CompanyModel2 *companyModel = _companyArray[indexPath.row - 1];
            SearchViewCell *searchCell = [SearchViewCell cellWithTableView:tableView];
            searchCell.modelCompany = companyModel;
            /* 忽略点击效果 */
            [searchCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return searchCell;

        } else if (indexPath.section == 3) {
            if (_orgArray.count < 1) {
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"orgCell"];
                return cell;
            }
            
            if (indexPath.row == 0) {
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"orgCell"];
                cell.textLabel.text = @"投资机构";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = fontCOLOR;
                return cell;
                
            }
            
            OrgModel *orgModel = _orgArray[indexPath.row - 1];
            SearchViewCell *searchCell = [SearchViewCell cellWithTableView:tableView];
            searchCell.modelOrg = orgModel;
            /* 忽略点击效果 */
            [searchCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return searchCell;

        }
        
        
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"kcell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_isReload) {
        [self.historyTableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == _myArray.count+1) {//清除所有历史记录
            [TokenTool removeAllArray];
            _myArray = nil;
            [self.historyTableView reloadData];
        }else{
            
        }
    } else {
        return;
    }
    
}


-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    _isReload = NO;
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    self.myArray = myArray;
    [self.historyTableView reloadData];
}

@end
