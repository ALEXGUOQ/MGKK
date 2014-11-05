// MGHelper.h
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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


/**
 *  小工具
 */
@interface MGHelper : NSObject


///-----------------------------------------------------------------------------
/// @name Class methods
///-----------------------------------------------------------------------------

/**
 *  返回收藏列表
 *
 *  @return 返回收藏列表
 */
+ (NSArray *)favoriteList;

/**
 *  新增一筆收藏
 *
 *  @param Id 收藏的 Id
 */
+ (void)addFavoriteId:(NSString *)Id;

/**
 *  刪除一筆收藏
 *
 *  @param Id 刪除的 Id
 */
+ (void)delFavoriteId:(NSString *)Id;


/**
 *  顯示 Alert
 *
 *  @param title   Alert title
 *  @param message Alert message
 *  @param mvc     Target
 */
+ (void)alert:(NSString *)title message:(NSString *)message inMVC:(UIViewController *)mvc;

/**
 *  播放影片
 *
 *  @param url 影片 URL
 *  @param mvc Target
 */
+ (void)playVideo:(NSURL *)url inMVC:(UIViewController *)mvc;

@end
