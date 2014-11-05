// MGDramaHeader.h
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

#import "LeanCloud.h"
#import <UIKit/UIKit.h>
@class MGDramaHeader;


/**
 *  MGDramaHeader protocol
 */
@protocol MGDramaHeaderDelegate <NSObject>


///-----------------------------------------------------------------------------
/// @name Optional methods
///-----------------------------------------------------------------------------

@optional
/**
 *  點中 Header
 *
 *  @param header  Self
 *  @param section 點中的 Section
 */
- (void)header:(MGDramaHeader *)header didClickedAtSection:(NSInteger)section;

/**
 *  點中收藏按鈕
 *
 *  @param header  Self
 *  @param section 點中按鈕的 Section
 */
- (void)header:(MGDramaHeader *)header didClickedButtonAtSection:(NSInteger)section;

@end


/**
 *  MGiPhoneMainController / MGiPhoneFavoriteController 的 UITableViewHeaderFooterView
 */
@interface MGDramaHeader : UITableViewHeaderFooterView


///-----------------------------------------------------------------------------
/// @name Properties
///-----------------------------------------------------------------------------

/**
 *  點中的 callback
 */
@property (nonatomic, weak) id<MGDramaHeaderDelegate>delegate;


///-----------------------------------------------------------------------------
/// @name Public methods
///-----------------------------------------------------------------------------

/**
 *  設置
 *
 *  @param drama 影集資料
 *  @param color Content 顏色
 */
- (void)configureDrama:(AVObject *)drama withColor:(UIColor *)color;

@end
