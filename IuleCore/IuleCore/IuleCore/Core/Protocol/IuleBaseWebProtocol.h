//
//  IuleBaseWebProtocol.h
//  IuleCore
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol IuleBaseWebProtocol <NSObject>

@optional

- (void)iule_webView:(WKWebView *_Nullable)webView shouldStartLoadWithNavigationAction:(WKNavigationAction *_Nullable)navigationAction decisionHandler:(void (^_Nullable)(WKNavigationActionPolicy))decisionHandler;
- (void)iule_webViewDidStartLoad:(WKWebView *_Nullable)webView;
- (void)iule_webViewDidFinishLoad:(WKWebView *_Nullable)webView;
- (void)iule_webView:(WKWebView *_Nullable)webView didFailLoadWithError:(NSError *_Nullable)error;
- (void)iule_webViewAddUserScript:(WKWebView *_Nullable)webView;
- (void)iule_webViewDidReceiveScriptMessage:(WKScriptMessage *_Nullable)message;
@end
