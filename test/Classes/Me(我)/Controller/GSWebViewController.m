//
//  GSWebViewController.m
//  test
//
//  Created by 邵梦 on 2020/4/14.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSWebViewController.h"
#import <WebKit/WebKit.h>

@interface GSWebViewController ()
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation GSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     wkwebview（ios8.0）是webview 的升级  添加功能：  1、监听进度 2、缓存   3、前进  后推 刷新  直接调用 对象方法goBack、goForward、reload
     步骤：1、导入#import <WebKit/WebKit.h>
          2、添加 WebKit.framework(如果发现一个类没有定义表示没有框架编译 添加框架)
     */
    [self.view addSubview:self.webView];
    [self.webView addSubview:self.progressView];

    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
    
    //KVO 监听 来控制按钮是否可以点击
    /*
      addObserver 观察者
      forKeyPath 观察webView 的哪个属性
     KVO 注意点  一定要移除
     */
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
//    GoForwardbtn.enabled = self.webView.canGoForward;
//    GoForwardbtn.enabled = self.webView.caGoForwardk;
    
    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress == 1;
    

}
// KVO 注意点  一定要移除
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];

}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.frame;
//    self.progressView.gs_y = 64;
    self.progressView.gs_width = self.view.gs_width;
    self.progressView.gs_height = 6;

}
- (WKWebView *)webView{
    if(!_webView){
        _webView = [WKWebView new];
//        _webView.backgroundColor = [UIColor redColor];
    }
    return _webView;
}
- (UIProgressView *)progressView{
    if(!_progressView){
        _progressView = [UIProgressView new];
    }
    return _progressView;
}


@end
