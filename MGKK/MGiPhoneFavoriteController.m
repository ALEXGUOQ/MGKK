// MGiPhoneFavoriteController.m
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

#import "MGiPhoneFavoriteController.h"
#import "MGiPhoneMainController+Public.h"


@interface MGiPhoneFavoriteController ()

@property (nonatomic, strong) NSArray *dataSource;

@end


@implementation MGiPhoneFavoriteController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    self.headerColor = [UIColor purpleColor];
    
    [super viewDidLoad];
    [self __loadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(![self.dramas count])
    {
        UILabel *noti      = [[UILabel alloc]initWithFrame:self.view.bounds];
        noti.text          = @"沒有資料";
        noti.font          = [UIFont boldSystemFontOfSize:22.0];
        noti.shadowColor   = [UIColor blackColor];
        noti.shadowOffset  = CGSizeMake(1.0, 1.0);
        noti.textColor     = [UIColor lightGrayColor];
        noti.textAlignment = NSTextAlignmentCenter;
        
        self.tableView.backgroundView = noti;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return 0;
    }
    
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    return [self.dramas count];
}

#pragma mark - MGDramaHeaderDelegate
- (void)header:(MGDramaHeader *)header didClickedButtonAtSection:(NSInteger)section
{
    AVObject *drama = self.dramas[section];
    NSString *favId = drama[@"objectId"];
    
    [MGHelper delFavoriteId:favId];
    
    [self __loadData];
}

#pragma mark - 載入資料
- (void)__loadData
{
    self.clicked           = -1;
    NSArray *favorites     = [MGHelper favoriteList];
    NSArray *allDramas     = [LeanCloud singleton].dramas;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId in %@", favorites];
    self.dataSource        = [allDramas filteredArrayUsingPredicate:predicate];
    self.dramas            = _dataSource;

    [self.tableView reloadData];
}

@end
