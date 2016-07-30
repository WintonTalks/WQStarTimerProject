//
//  ViewController.m
//  WQStarTimerProject
//
//  Created by 孙文强 on 16/7/27.
//  Copyright © 2016年 Happy Day. All rights reserved.
//
#import "MyTableViewCell.h"
#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = ({
    
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        [self.view addSubview:tableView];
    
        tableView;
    });
    
    dataArr = [NSMutableArray arrayWithObjects:@"1473407775",@"1473407775",@"1473407765",@"1473407775",@"1473407770",@"1473407775",@"1473407775",@"1473407775",@"1473407775",@"1473407795", nil];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"reuseIdentifierID";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.endDate = dataArr[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
