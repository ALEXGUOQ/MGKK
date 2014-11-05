// MGFetchViewController.h
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
@class MGFetchViewController;


/**
 *  MGFetchViewController protocol
 */
@protocol MGFetchViewControllerDelegate <NSObject>


///-----------------------------------------------------------------------------
/// @name Required methods
///-----------------------------------------------------------------------------

/**
 *  解析完的 callback
 *
 *  @param mvc Self
 *  @param url 解析到的影片 URL
 */
- (void)mvc:(MGFetchViewController *)mvc didFetchedVideo:(NSURL *)url;

@end


/**
 *  解析影片 mvc
 */
@interface MGFetchViewController : UIViewController


///-----------------------------------------------------------------------------
/// @name Properies
///-----------------------------------------------------------------------------

/**
 *  解析完的 callback
 */
@property (nonatomic, weak) id<MGFetchViewControllerDelegate>delegate;

/**
 *  要解析的影片網址
 */
@property (nonatomic, copy) NSString *fetchURL;

@end
