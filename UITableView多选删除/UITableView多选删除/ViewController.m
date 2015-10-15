//
//  ViewController.m
//  UITableView多选删除
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "FileItemTableCell.h"

@interface Item : NSObject

@property (retain, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL isChecked;

@end

@implementation Item


@end
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate> {
    BOOL _isAllCheched;//全选状态
}

@property (nonatomic,strong)UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *items;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self  action:@selector(setEditing:animated:)];
        self.navigationItem.rightBarButtonItem = right;
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonPressed)];
        self.navigationItem.leftBarButtonItem = left;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button setTitle:@"全选" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = button;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.rowHeight = 50;
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.items = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<5; i++) {
        Item *item = [[Item alloc] init];
        item.title = [NSString stringWithFormat:@"%d",i];
        item.isChecked = NO;
        [_items addObject:item];
    }
}

- (void)buttonPressed:(UIButton *)sender {
    if (_tableView.editing) {
//        sender.selected = !sender.selected;
        _isAllCheched=!_isAllCheched;
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:_items];
        //点击全选
        if (_isAllCheched) {
            for (int i = 0; i < array.count; i ++) {
                Item* item = [array objectAtIndex:i];
                
                
                item.isChecked = YES;
            
            }
        }else {
            for (int i = 0; i < array.count; i ++) {
                Item* item = [array objectAtIndex:i];
                
                
                item.isChecked = NO;
            
            }
        }
        _items = [[NSMutableArray alloc]initWithArray:array];
        [_tableView reloadData];
    }
   
}

- (void)leftBarButtonPressed {
    NSLog(@"删除");
    if (_tableView.editing) {
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:_items];
        for (int i = 0; i < array.count; i ++) {
            Item* item = [array objectAtIndex:i];
            if (item.isChecked) {
                [_items removeObject:item];
            }
        }
        [_tableView reloadData];
        _isAllCheched = NO;
        NSLog(@"%ld",_items.count);
    }
   
}

- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem.title = _tableView.editing ? @"Edit" : @"Done";
    [_tableView setEditing:!_tableView.editing animated:YES];
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    FileItemTableCell *cell = (FileItemTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FileItemTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [cell.textLabel.font fontWithSize:17];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor blackColor];
    
    Item* item = [_items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    [cell setChecked:item.isChecked];
    return cell;;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item* item = [_items objectAtIndex:indexPath.row];
    
    if (self.tableView.editing)
    {
        FileItemTableCell *cell = (FileItemTableCell*)[tableView cellForRowAtIndexPath:indexPath];
        item.isChecked = !item.isChecked;
        [cell setChecked:item.isChecked];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
