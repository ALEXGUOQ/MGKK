// MGDramaCell.h
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
@class MGDramaCell;


/**
 *  MGDramaCell protocol
 */
@protocol MGDramaCellDelegate <NSObject>


///-----------------------------------------------------------------------------
/// @name Optional methods
///-----------------------------------------------------------------------------

@optional
/**
 *  點中收藏按鈕
 *
 *  @param row 點中的 row
 */
- (void)cell:(MGDramaCell *)cell didClickedButtonAtRow:(NSInteger)row;

@end


/**
 *  MGiPadMainController / MGiPadFavoriteController 的 UITableViewCell
 */
@interface MGDramaCell : UITableViewCell


///-----------------------------------------------------------------------------
/// @name Properties
///-----------------------------------------------------------------------------

/**
 *  點擊收藏 callback
 */
@property (nonatomic, weak) id<MGDramaCellDelegate>delegate;


///-----------------------------------------------------------------------------
/// @name Public methods
///-----------------------------------------------------------------------------

/**
 *  設置
 *
 *  @param drama 影集資料
 *  @param color contentView 顏色
 */
- (void)configureDrama:(AVObject *)drama withColor:(UIColor *)color;

@end
