// MGHelper.m
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

#import "MGHelper.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


@implementation MGHelper

#pragma mark - 收藏列表
+ (NSArray *)favoriteList
{
    return [[NSUserDefaults standardUserDefaults]arrayForKey:@"kFavorite"];
}

#pragma mark - 新增收藏
+ (void)addFavoriteId:(NSString *)Id
{
    NSArray *temp = [MGHelper favoriteList];
    
    // 加過了
    if([temp containsObject:Id])
    {
        return;
    }
    
    NSMutableArray *favorite = [NSMutableArray arrayWithArray:temp];
    
    [favorite addObject:Id];
    [[NSUserDefaults standardUserDefaults]setObject:favorite forKey:@"kFavorite"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - 移除收藏
+ (void)delFavoriteId:(NSString *)Id
{
    NSArray *temp = [MGHelper favoriteList];
    NSMutableArray *favorite = [NSMutableArray arrayWithArray:temp];
    
    [favorite removeObject:Id];
    [[NSUserDefaults standardUserDefaults]setObject:favorite forKey:@"kFavorite"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - 顯示 Alert
+ (void)alert:(NSString *)title message:(NSString *)message inMVC:(UIViewController *)mvc
{
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"確定"
                                                 style:UIAlertActionStyleCancel
                                               handler:nil];
    
    [alert addAction:OK];
    
    [mvc presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 播放影片
+ (void)playVideo:(NSURL *)url inMVC:(UIViewController *)mvc
{
    AVPlayerViewController *play = [[AVPlayerViewController alloc]init];
    AVPlayer *player             = [AVPlayer playerWithURL:url];
    play.player                  = player;
    
    [mvc presentViewController:play animated:YES completion:^{
        [player play];
    }];
}

@end
