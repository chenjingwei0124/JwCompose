//
//  JwFindController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwFindController.h"
#import "JwFindCell.h"
#import "JwFineModel.h"

@interface JwFindController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation JwFindController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    [self setupData];
}

- (void)setupView{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0,
                                                                    kJwScreenNavBatBarHeight,
                                                                    self.view.jw_width,
                                                                    self.view.jw_height - kJwScreenNavBatBarHeight - kJwScreenTabBottomBarHeight))
                                                  style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[JwFindCell class] forCellReuseIdentifier:@"JwFindCell"];

}

- (void)setupData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"subs" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(kNilOptions) error:nil];
    self.datas = [NSMutableArray arrayWithArray:[JwFineModel arrayOfModelsFromDictionaries:dic[@"data"] error:nil]];
    [JwProjectModel registerTableView:self.tableView cellClassWithDatas:self.datas];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    JwProjectModel *projectModel = self.datas[section];
    return projectModel.jw_itemCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JwProjectModel *projectModel = self.datas[indexPath.section];
    JwFindCell *cell = [tableView dequeueReusableCellWithIdentifier:projectModel.jw_cellName forIndexPath:indexPath];
    JwFineModel *model = projectModel.jw_itemDatas[indexPath.row];
    cell.content = model.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JwProjectModel *projectModel = self.datas[indexPath.section];
    JwFineModel *model = projectModel.jw_itemDatas[indexPath.row];
    return model.jw_cellSize.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
