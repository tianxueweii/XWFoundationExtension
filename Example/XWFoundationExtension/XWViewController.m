//
//  XWViewController.m
//  XWFoundationExtension
//
//  Created by tianxueweii on 01/08/2019.
//  Copyright (c) 2019 tianxueweii. All rights reserved.
//

#import "XWViewController.h"
#import "UIImage+XWFeatureExt.h"

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
                            @{
                                PROJ_DEMO_TABLE_CELL_TITLE_KEY:@"异步绘制红色方块图片",
                                PROJ_DEMO_TABLE_CELL_BLOCK_KEY:^{
                                    [UIImage xw_drawImageWithColor:UIColor.redColor size:CGSizeMake(80, 50) completion:^(UIImage * _Nonnull img) {
                                        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
                                        [self.view addSubview:imageView];
                                        imageView.center = self.view.center;
                                        
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            [imageView removeFromSuperview];
                                        });
                                    }];
                                },
                            },
                            @{
                                PROJ_DEMO_TABLE_CELL_TITLE_KEY:@"异步绘制蓝色圆形图片",
                                PROJ_DEMO_TABLE_CELL_BLOCK_KEY:^{
                                    [UIImage xw_drawCircleImageWithColor:UIColor.blueColor diam:100 completion:^(UIImage * _Nonnull img) {
                                        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
                                        
                                        [self.view addSubview:imageView];
                                        imageView.center = self.view.center;
                                        
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            
                                            [imageView removeFromSuperview];
                                        });
                                    }];
                                   
                                    
                                },
                            },
                            @{
                                PROJ_DEMO_TABLE_CELL_TITLE_KEY:@"绘制文字图片",
                                PROJ_DEMO_TABLE_CELL_BLOCK_KEY:^{
                                    UIImage *image =
                                    [UIImage xw_imageWithString:@"Hello World"
                                                     attributes:@{
                                                                  NSFontAttributeName : [UIFont systemFontOfSize:40],
                                                                  NSForegroundColorAttributeName : UIColor.whiteColor,
                                                                }
                                                backgroundColor:UIColor.blackColor];
                                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                                    [self.view addSubview:imageView];
//                                    imageView.frame = CGRectMake(0, 0, 100, 44);
                                    imageView.center = self.view.center;
                                    
                                    
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        
                                        [imageView removeFromSuperview];
                                    });
                                }
                            },
                            @{
                                PROJ_DEMO_TABLE_CELL_TITLE_KEY:@"裁剪图片圆角",
                                PROJ_DEMO_TABLE_CELL_BLOCK_KEY:^{
                                    
                                    UIImage * image = [[UIImage imageNamed:@"source"] xw_clipBorderWithRoundedCorners:UIRectCornerTopLeft | UIRectCornerBottomRight radius:20];
                                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                                    [self.view addSubview:imageView];
                                    imageView.center = self.view.center;
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [imageView removeFromSuperview];
                                    });
                                
                                }
                            },
                            @{
                                PROJ_DEMO_TABLE_CELL_TITLE_KEY:@"异步裁剪竖型圆形图片",
                                PROJ_DEMO_TABLE_CELL_BLOCK_KEY:^{

                                    [UIImage xw_clipCircleImage:[UIImage imageNamed:@"source3"]  completion:^(UIImage * _Nonnull img) {
                                        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
                                        [self.view addSubview:imageView];
                                        imageView.center = self.view.center;
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            [imageView removeFromSuperview];
                                        });
                                    }];
                                }
                                },
                            
                            
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
