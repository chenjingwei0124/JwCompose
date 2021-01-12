//
//  JwHomeController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwHomeController.h"
#import "JwClassifyCell.h"

@interface JwHomeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation JwHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    [self setupView];
    [self.tableView jw_mj_headerBeginRefreshing];
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
    [self.tableView registerClass:[JwClassifyCell class] forCellReuseIdentifier:@"JwClassifyCell"];
    
    Weak(self);
    //下拉
    [self.tableView jw_mj_headerWithRefreshingBlock:^(UIScrollView *scrollView) {
        [wself requestData];
    }];
    //上拉
    [self.tableView jw_mj_footerWithRefreshingState:(Jw_FooterStateDefault) block:^(UIScrollView *scrollView) {
        [wself.tableView jw_mj_setFooterIsNoMore:YES];
    }];
    //空白页
    self.tableView.jw_didShowBackAction = ^(UIView *view) {
        [wself.tableView jw_mj_headerBeginRefreshing];
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JwClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JwClassifyCell" forIndexPath:indexPath];
    JwClassifyModel *model = self.datas[indexPath.row];
    cell.content = model.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [UIAlertView showWithTitle:@"提示" message:@"本页面测试网络请求以及断网时简单的遮罩层界面" cancelButtonTitle:@"确定" action:^{
    }];
}

- (void)requestData{
    [[[JwDataService alloc] init] firstEntrySuccess:^(NSMutableArray * _Nonnull entrys, id  _Nonnull data) {
        
        self.datas = [NSMutableArray arrayWithArray:entrys];
        [self.tableView reloadData];
        
        [self.tableView jw_mj_headerEndRefreshing];
        [self.tableView jw_mj_footerEndRefreshing];
        
        //判断空白页
        if (self.datas.count > 0) {
            [self.tableView jw_removeShowBackView];
        }else{
            [self.tableView jw_setupShowBackViewWithState:(Jw_ViewStateNothing)];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [self.tableView jw_mj_headerEndRefreshing];
        [self.tableView jw_mj_footerEndRefreshing];
        
        [self.tableView jw_setupShowBackViewWithState:(Jw_ViewStateError)];
    }];
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

