//
//  DVBaseWebVC.m
//  MakeHave
//
//  Created by pppsy on 15/11/18.
//  Copyright © 2015年 makehave. All rights reserved.
//

#import "DVBaseWebVC.h"

@interface DVBaseWebVC ()<UIWebViewDelegate>

@end

@implementation DVBaseWebVC

- (void)dealloc
{
    _webView.delegate = nil;
}
- (id)initWithURL:(NSURL*)url
{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)loadView
{
    self.view = self.webView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadRequestWithURL:_url];
}

- (void)loadRequestWithURL:(NSURL*)url
{
    self.url = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (UIWebView*)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

- (UIActivityIndicatorView*)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        [self.view addSubview:_indicatorView];
    }
    
    return _indicatorView;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    BOOL shouldStart = YES;
    //    if ([_delegate respondsToSelector:@selector(webViewController:shouldLoadRequest:navigationType:)]) {
    //        shouldStart =  [_delegate webViewController:self shouldLoadRequest:request navigationType:navigationType];
    //    }
    if (shouldStart) {
        [self.indicatorView startAnimating];
    }
    
    return shouldStart;
}

- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [self.indicatorView stopAnimating];
}


@end
