//
//  DVBaseWebVC.h
//  MakeHave
//
//  Created by pppsy on 15/11/18.
//  Copyright © 2015年 makehave. All rights reserved.
//

#import "DVBaseVC.h"

@interface DVBaseWebVC : DVBaseVC
@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) UIActivityIndicatorView* indicatorView;

- (id)initWithURL:(NSURL*)url;
- (void)loadRequestWithURL:(NSURL*)url;

@end


