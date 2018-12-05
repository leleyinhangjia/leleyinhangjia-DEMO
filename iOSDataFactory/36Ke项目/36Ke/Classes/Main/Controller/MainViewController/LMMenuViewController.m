//
//  LMMenuViewController.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"
#import "LMTabBarController.h"
#import "MenuViewCell.h"

@interface LMMenuViewController ()

@property (nonatomic, assign) NSInteger preIndex;

@end

@implementation LMMenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    _preIndex = 0;
    //    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0f)];
        //        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [imageBtn setImage:[UIImage imageNamed:@"news_toolbar_icon_back"] forState:UIControlStateNormal];
        //        [imageBtn setFrame:CGRectMake(10, 28, 25, 25)];
        //        [imageBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 28, 25, 25)];
         imageView.userInteractionEnabled = YES;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"news_toolbar_icon_back"];
//        imageView.layer.masksToBounds = YES;
//        imageView.layer.cornerRadius = 50.0;
//        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        imageView.layer.borderWidth = 3.0f;
//        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        imageView.layer.shouldRasterize = YES;
//        imageView.clipsToBounds = YES;
        [imageView addGestureRecognizer:singleFingerOne];
        [view addSubview:imageView];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
//{
//    if (sectionIndex == 0)
//        return nil;
//
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
//    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
//    label.text = @"Friends Online";
//    label.font = [UIFont systemFontOfSize:15];
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor clearColor];
//    [label sizeToFit];
//    [view addSubview:label];
//
//    return view;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_preIndex == indexPath.row) {
        [self.frostedViewController hideMenuViewController];
        return;
    }
    
    _preIndex = indexPath.row;
    LMTabBarController *tabBar;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            tabBar = [[LMTabBarController alloc] initColumn:@"all" title:@"新闻"];
            break;
        case 1:
            tabBar = [[LMTabBarController alloc] initColumn:@"67" title:@"早起项目"];
            break;
        case 2:
            tabBar = [[LMTabBarController alloc] initColumn:@"68" title:@"B轮后"];
            break;
        case 3:
            tabBar = [[LMTabBarController alloc] initColumn:@"23" title:@"大公司"];
            break;
        case 4:
            tabBar = [[LMTabBarController alloc] initColumn:@"69" title:@"资本"];
            break;
        case 5:
            tabBar = [[LMTabBarController alloc] initColumn:@"70" title:@"深度"];
            break;
        case 6:
            tabBar = [[LMTabBarController alloc] initColumn:@"71" title:@"研究"];
            break;
        case 7:
            tabBar = [[LMTabBarController alloc] initColumn:@"tv" title:@"氪TV"];
        default:
            break;
    }
    self.frostedViewController.contentViewController = tabBar;
    [self.frostedViewController hideMenuViewController];
}

- (void)back {
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray *titles = @[@"全部", @"早期项目", @"B轮后",@"大公司", @"资本", @"深度",@"研究",@"氪TV"];
    NSArray *viewColor = @[@"#000000",@"#52AC41",@"#47B1E7",@"#2B88F5",@"#0045CA",@"#D6253A",@"#DF7515",@"#D62846"];
    MenuViewCell *cell = [MenuViewCell cellWithTableView:tableView viewColor:viewColor[indexPath.row] nameLabel:titles[indexPath.row]];
//    cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}

@end
