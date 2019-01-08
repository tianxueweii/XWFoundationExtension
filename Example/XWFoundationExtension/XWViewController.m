//
//  XWViewController.m
//  XWFoundationExtension
//
//  Created by tianxueweii on 01/08/2019.
//  Copyright (c) 2019 tianxueweii. All rights reserved.
//

#import "XWViewController.h"

#define PROJ_DEMO_TABLE_CELL_TITLE_KEY @"demo_title"
#define PROJ_DEMO_TABLE_CELL_BLOCK_KEY @"demo_block"

typedef void (^ProjDemoTableCellBlock)(void);

@interface XWViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 列表 */
@property(nonatomic, strong)UITableView *tableView;
/** 列表数据 */
@property(nonatomic, strong)NSArray *tableViewDatas;
@end

@implementation XWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

/**
 该位置添加名称及对应事件
 */
- (NSArray *)tableViewDatas{
    if (!_tableViewDatas) {
        _tableViewDatas = @[
                            //@{
                            //    PROJ_DEMO_TABLE_CELL_TITLE_KEY:@"<#列表项标题#>",
                            //    PROJ_DEMO_TABLE_CELL_BLOCK_KEY:<#^(void)列表点击事件#>,
                            //},
                            ];
    }
    return _tableViewDatas;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.rowHeight = 80.f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableViewDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.tableViewDatas[indexPath.row][PROJ_DEMO_TABLE_CELL_TITLE_KEY];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ProjDemoTableCellBlock block = self.tableViewDatas[indexPath.row][PROJ_DEMO_TABLE_CELL_BLOCK_KEY];
    if (block) {
        block();
    }
}

@end
