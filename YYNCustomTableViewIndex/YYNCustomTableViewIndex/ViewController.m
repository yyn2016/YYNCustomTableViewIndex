//
//  ViewController.m
//  YYNCustomTableViewIndex
//
//  Created by czf1 on 17/3/15.
//  Copyright © 2017年 杨亚楠. All rights reserved.
//

#import "ViewController.h"
#import "YYNTableViewIndexView.h"

static NSString *cellIdentifier = @"tableviewCell";

@interface ViewController ()<YYNTableViewIndexViewDataSource, YYNSectionIndexViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *sections;

@property (nonatomic, strong)YYNTableViewIndexView *indexView;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.sections = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
    
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 27; i++) {
        NSMutableArray *sections = [[NSMutableArray alloc] init];
        for (int j = 0; j < 4; j++) {
            [sections addObject:@"自定义索引条"];
        }
        [_dataSource addObject:sections];
    }
    
    [self tableView];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        [self.view addSubview:_tableView];
        [self indexView];
    }
    return _tableView;
}

- (YYNTableViewIndexView *)indexView{
    if (_indexView == nil) {
        _indexView = [[YYNTableViewIndexView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 20, 0, 20, self.view.frame.size.height)];
        _indexView.backgroundColor = [UIColor clearColor];
        _indexView.itemHeight = ([UIScreen mainScreen].bounds.size.height) / _sections.count;
        
        _indexView.dataSource = self;
        _indexView.delegate = self;
        
        [_indexView reloadItemViews];
        
        [self.view addSubview:_indexView];
    }
    return _indexView;
}

#pragma mark - 索引代理方法
- (YYNTableViewIndexItemView *)sectionIndexView:(YYNTableViewIndexView *)sectionIndexView itemViewForSection:(NSInteger)section{
    
    YYNTableViewIndexItemView *itemView = [[YYNTableViewIndexItemView alloc] init];
    
    itemView.titleLabel.text = [self.sections objectAtIndex:section];
    itemView.titleLabel.font = [UIFont systemFontOfSize:12];
    itemView.titleLabel.textColor = [UIColor grayColor];
    itemView.titleLabel.highlightedTextColor = [UIColor grayColor];
    itemView.titleLabel.shadowColor = [UIColor whiteColor];
    itemView.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    return itemView;
}

//返回一共有多少组
- (NSInteger)numberOfItemViewForSectionIndexView:(YYNTableViewIndexView *)sectionIndexView
{
    return self.sections.count;
}

//选中索引后做相应的操作
- (void)sectionIndexView:(YYNTableViewIndexView *)sectionIndexView
        didSelectSection:(NSInteger)section{
    NSString *chaStr = _sections[section];
    for (int i = 0; i < _sections.count; i++) {
        if ([chaStr isEqualToString:_sections[i]]) {
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            return;
        }
    }
    return;
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.sections[section];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
