//
//  JwWebController.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/12/12.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwWebController.h"
#import <WebKit/WebKit.h>
#import "JwWeakScriptMessageDelegate.h"

@interface JwWebController ()<WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation JwWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"WKWebView";
    [self setupView];
}

- (void)setupView{
    [self.view addSubview:self.webView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"OCJS" style:(UIBarButtonItemStylePlain) target:self action:@selector(OCJSAction)];
}

- (void)dealloc{
    [[self.webView configuration].userContentController removeScriptMessageHandlerForName:@"iOSJS"];
}

- (void)OCJSAction{
    NSString *jsString = [NSString stringWithFormat:@"changeColor()"];
    [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        DLog(@"改变div的背景色");
    }];
}

- (WKWebView *)webView{
    if (_webView == nil) {
        //网络配置
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        //设置队形
        WKPreferences *preference = [[WKPreferences alloc] init];
        preference.minimumFontSize = 0;
        preference.javaScriptEnabled = YES;
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        config.allowsInlineMediaPlayback = YES;
        if (@available(iOS 9.0, *)) {
            config.requiresUserActionForMediaPlayback = YES;
            config.allowsPictureInPictureMediaPlayback = YES;
            config.applicationNameForUserAgent = @"JwCompose";
        }
        
        JwWeakScriptMessageDelegate *weakDelegate = [[JwWeakScriptMessageDelegate alloc] initWithDelegate:self];
        WKUserContentController *wkUC = [[WKUserContentController alloc] init];
        [wkUC addScriptMessageHandler:weakDelegate name:@"iOSJS"];
        config.userContentController = wkUC;
        
        _webView = [[WKWebView alloc] initWithFrame:(CGRectMake(0, kJwScreenNavBatBarHeight, self.view.jw_width, self.view.jw_height - kJwScreenNavBatBarHeight)) configuration:config];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JSOC" ofType:@"html"];
        NSString *htmlString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    return  _webView;
}

//WKScriptMessageHandler

//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    DLog(@"name:%@ body:%@ frameInfo:%@",message.name,message.body,message.frameInfo);
    
    NSString *param = [NSString stringWithFormat:@"name:%@\nbody:%@", message.name, message.body];
    [LBXAlertAction showAlertWithTitle:@"JS调用OC" msg:param buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
    }];
}

//WKNavigationDelegate

//在发送请求前决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    DLog(@"%@", navigationAction.request.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);//允许
    //decisionHandler(WKNavigationActionPolicyCancel);//不允许
}

//在收到响应后决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    DLog(@"%@", navigationResponse.response.URL.absoluteString);
    decisionHandler(WKNavigationResponsePolicyAllow);//允许
    //decisionHandler(WKNavigationResponsePolicyCancel);//不允许
}

//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

//WKUIDelegate

//弹出窗
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

//警告框 alert
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    [LBXAlertAction showAlertWithTitle:@"警告框" msg:message buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
        completionHandler();
    }];
}

//确认框 confirm
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
}

//输入框 prompt
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
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
