//
//  IuleBaseWebViewController.m
//  IuleCore
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 iule. All rights reserved.
//

#import "IuleBaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "IuleConst.h"

@interface IuleBaseWebViewController ()<WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation IuleBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark - private methods

- (void)loadUrl:(NSString *)url frame:(CGRect)frame {
    [self loadUrl:url frame:frame referer:@""];
}

- (void)loadUrl:(NSString *)url frame:(CGRect)frame referer:(NSString *)referer {
    NSString *encodeUrl = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodeUrl]];
    if (referer.length > 0) {
        [request addValue:referer forHTTPHeaderField:@"Referer"];
    }
    [self.webView loadRequest:request];
    self.webView.frame = frame;
}

- (void)loadHTMLString:(NSString *)HTMLString frame:(CGRect)frame {
    [self.webView loadHTMLString:HTMLString baseURL:nil];
    self.webView.frame = frame;
}

#pragma mark -
#pragma mark - WKNavigationDelegate

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    IuleLog(@"发送跳转请求：%@",urlStr);
    if ([self.delegate respondsToSelector:@selector(iule_webView:shouldStartLoadWithNavigationAction:decisionHandler:)]) {
        [self.delegate iule_webView:webView shouldStartLoadWithNavigationAction:navigationAction decisionHandler:decisionHandler];
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}


// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    IuleLog(@"当前跳转地址：%@",urlStr);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    if ([self.delegate respondsToSelector:@selector(iule_webViewDidStartLoad:)]) {
        [self.delegate iule_webViewDidStartLoad:webView];
    }
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    if ([self.delegate respondsToSelector:@selector(iule_webViewDidFinishLoad:)]) {
        [self.delegate iule_webViewDidFinishLoad:webView];
    }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(iule_webView:didFailLoadWithError:)]) {
        [self.delegate iule_webView:webView didFailLoadWithError:error];
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}
//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
    
}

#pragma mark -
#pragma mark - WKScriptMessageHandler

//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    IuleLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //用message.body获得JS传出的参数体
    NSDictionary * parameter = message.body;
    //JS调用OC
    IuleLog(@"%@",parameter);

    if ([self.delegate respondsToSelector:@selector(iule_webViewDidReceiveScriptMessage:)]) {
        [self.delegate iule_webViewDidReceiveScriptMessage:message];
    }
}

#pragma mark -
#pragma mark - observe progress

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            static double progress = 0;
            if (progress<self.webView.estimatedProgress) {
                progress = self.webView.estimatedProgress;
            }
            if(self.webView.estimatedProgress >= 1.0f) {
                
            }
        }else if ([keyPath isEqualToString:@"title"]) {
//            self.ly_navigationBar.title = self.webView.title;
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark -
#pragma mark - interface


#pragma mark -
#pragma mark - lazy

- (WKWebView *)webView {
    if (!_webView) {
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = YES;
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        config.requiresUserActionForMediaPlayback = YES;
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        config.applicationNameForUserAgent = @"iule";
        //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
        
        //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //注册一个js方法
        [wkUController addScriptMessageHandler:self name:@"kqhb"];
        config.userContentController = wkUController;
        //用完记得移除
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        [self.view addSubview:_webView];
        
        if ([self.delegate respondsToSelector:@selector(iule_webViewAddUserScript:)]) {
            [self.delegate iule_webViewAddUserScript:_webView];
        }
        
        [self.view bringSubviewToFront:self.iule_navigationBar];
        
        // 导航代理
        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
//        //可返回的页面列表, 存储已打开过的网页
//        WKBackForwardList * backForwardList = [_webView backForwardList];
//        //页面后退
//        [_webView goBack];
//        //页面前进
//        [_webView goForward];
//        //刷新当前页面
//        [_webView reload];
        
        //监听加载进度
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _webView;
}

#pragma mark -
#pragma mark - dealloc

- (void)dealloc {
    //移除注册的js方法
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

@end
