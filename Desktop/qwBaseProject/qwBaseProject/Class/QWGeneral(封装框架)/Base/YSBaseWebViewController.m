//
//  YSBaseWebViewController.m
//  GoFish
//
//  Created by Magic-Yu on 2018/3/12.
//  Copyright © 2018年 Magic-Yu. All rights reserved.
//

#import "YSBaseWebViewController.h"

@interface YSBaseWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation YSBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWebView];
    self.url = _url;
    
}

- (void)configWebView{
    
    WKUserContentController *userCC = [[WKUserContentController alloc] init];
    [userCC addScriptMessageHandler:self name:@"webviewEvent"];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userCC;
    CGRect frame = self.view.bounds;

    
    frame.size.height = kSCREEN_HEIGHT - (kNAV_HEIGHT);
    
    frame.size.height -= kX(49);
    WKWebView *webView = [[WKWebView alloc] initWithFrame:frame configuration:config];
    
    [self.view addSubview:webView];
    
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    self.title = @"测试";
    
    self.webView = webView;
}

- (void)setUrl:(NSString *)url{
    _url = url;
    
    if (!_webView) {
        return;
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.webView loadRequest:urlRequest];
    
}



#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler{
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSString *msgName = message.name;
    if ([msgName isEqualToString:@"webviewEvent"]) {
        [self handleWebViewEvent:message];
    }
    
}

// 交由子类去继承
- (void)handleWebViewEvent:(WKScriptMessage*)message{
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}




@end
