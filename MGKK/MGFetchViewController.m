// MGFetchViewController.m
// 
// Copyright (c) 2014年 Shinren Pan
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "Ono.h"
#import <WebKit/WebKit.h>
#import "SRPBlurPresentation.h"
#import "MGFetchViewController.h"


@interface MGFetchViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end


@implementation MGFetchViewController

#pragma mark - LifeCycle
- (void)dealloc
{
    // 移除 KVO
    [_webView removeObserver:self forKeyPath:@"loading"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setup];
}

#pragma mark - WebView KVO handle
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    BOOL loading = [change[@"new"]boolValue];
    
    if(!loading)
    {
        // 停個 0.5 秒比較穩
        [self performSelector:@selector(__webViewLoadedHandel) withObject:nil afterDelay:0.5];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:
(UIViewController *)presented presentingViewController:(UIViewController *)
presenting sourceViewController:(UIViewController *)source
{
    return [[SRPBlurPresentation alloc]initWithPresentedViewController:presented
                                              presentingViewController:presenting];
}

#pragma mark - 按下取消
- (IBAction)cancelButtonDidClicked:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 初始設置
- (void)__setup
{
    self.webView = [[WKWebView alloc]init];
    
    [_webView addObserver:self forKeyPath:@"loading"
                  options:NSKeyValueObservingOptionNew context:nil];
    
    self.fetchURL = [NSString stringWithFormat:@"http://www.flvxz.com/?url=%@", _fetchURL];
    
    NSURL *URL = [NSURL URLWithString:_fetchURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [_webView loadRequest:request];
}

#pragma mark - _webView stop handle
- (void)__webViewLoadedHandel
{
    // 取回 webView node HTML, 然後 parse
    [_webView evaluateJavaScript:@"document.getElementById('result').innerHTML"
               completionHandler:^(id HTML, NSError *err){
        if(err)
        {
            [_delegate mvc:self didFetchedVideo:nil];
        }
        else
        {
            [self __parseHTML:HTML];
        }
    }];
}

#pragma mark - 爬影片來源
- (void)__parseHTML:(NSString *)html
{
    NSError *err;
    ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithString:html
                                                             encoding:NSUTF8StringEncoding
                                                                error:&err];
    
    if(err)
    {
        [_delegate mvc:self didFetchedVideo:nil];
    }
    else
    {
        __block NSString *videoURL;
        NSString *xPath = @"//a[@rel='noreferrer']";
        
        [document enumerateElementsWithXPath:xPath
                                  usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop){
            NSString *name = [element stringValue];
            NSString *url  = [element valueForAttribute:@"href"];
            NSRange mp4    = [name rangeOfString:@"mp4"];
            
            // 只要爬到第一個 mp4 檔就停止
            if(mp4.location != NSNotFound)
            {
                videoURL = url;
                *stop = YES;
            }
        }];
        
        [_delegate mvc:self didFetchedVideo:[NSURL URLWithString:videoURL]];
    }
}

@end
