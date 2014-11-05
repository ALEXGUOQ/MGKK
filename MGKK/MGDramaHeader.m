// MGDramaHeader.m
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
#import "MGDramaHeader.h"


@interface MGDramaHeader ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *finishLabel;
@property (nonatomic, weak) IBOutlet UIView *content;
@property (nonatomic, weak) IBOutlet UIButton *favButton;

@end

@implementation MGDramaHeader

#pragma mark - LifeCycle
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
    
    [self addGestureRecognizer:tap];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _nameLabel.text   = nil;
    _finishLabel.text = nil;
}

#pragma mark - 設置
- (void)configureDrama:(AVObject *)drama withColor:(UIColor *)color
{
    [self __setupFavButtonColor:drama[@"objectId"]];
    
    BOOL finish       = [drama[@"finish"]boolValue];
    _nameLabel.text   = drama[@"name"];
    _finishLabel.text = finish ? @"已完結" : @"連載中";

    if(color)
    {
        _content.backgroundColor = color;
    }
}

#pragma mark - 點中收藏按鈕
- (IBAction)favBurronDidClicked:(id)sender
{
    [_delegate header:self didClickedButtonAtSection:self.tag];
}

#pragma mark - 點中 Header
- (void)tapHandle:(id)sender
{
    [_delegate header:self didClickedAtSection:self.tag];
}

#pragma mark - 設置收藏按鈕顏色
- (void)__setupFavButtonColor:(NSString *)favId
{
    if([[MGHelper favoriteList]containsObject:favId])
    {
        _favButton.tintColor = [UIColor orangeColor];
    }
    else
    {
        _favButton.tintColor = [UIColor whiteColor];
    }
}

@end
