// MGiPhoneMainController.m
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

#import "MGiPhoneMainController.h"
#import "MGiPhoneMainController+Public.h"


@interface MGiPhoneMainController ()<UISearchBarDelegate>

@property (nonatomic, assign) BOOL enterSearch;
@property (nonatomic, strong) NSArray *searchReslut;
@property (nonatomic, strong) GADBannerView *banner;

@end


@implementation MGiPhoneMainController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setup];
    //[self __setupAdMob];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 每次進來都要 reload 跟 check, 因為可能在收藏裡有刪除
    [self __reload];
}

#pragma mark - Properties Setter
- (void)setSearchReslut:(NSArray *)searchReslut
{
    // 利用 _searchReslut Setter 來改變 _drams;
    // 如果 _searchReslut 為 nil, 就載入原來的全部資料

    self.clicked  = -1;
    _searchReslut = searchReslut;
    self.dramas   = _searchReslut;
    
    if(_searchReslut == nil)
    {
        self.dramas = [LeanCloud singleton].dramas;
    }
    
    [self __reload];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(![_dramas count])
    {
        // 沒有資料時
        
        UILabel *noti      = [[UILabel alloc]initWithFrame:self.view.bounds];
        noti.text          = _enterSearch ? @"找不到搜尋資料" : @"請下拉更新";
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
    
    return [_dramas count];
}

#pragma mark - MGDramaHeaderDelegate
- (void)header:(MGDramaHeader *)header didClickedButtonAtSection:(NSInteger)section
{
    AVObject *drama = _dramas[section];
    NSString *favId = drama[@"objectId"];
    
    if([[MGHelper favoriteList]containsObject:favId])
    {
        [MGHelper delFavoriteId:favId];
    }
    else
    {
        [MGHelper addFavoriteId:favId];
    }
    
    [self __reload];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.enterSearch            = YES;
    searchBar.showsCancelButton = YES;
    
    // 如果剛進來, 沒有輸入東西, 就清空
    if(![searchBar.text length])
    {
        [self __cleanDramas];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *input  = searchBar.text;
    NSString *search = [input stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([search length])
    {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", search];
        self.searchReslut = [[LeanCloud singleton].dramas filteredArrayUsingPredicate:pred];
    }
    
    // 如果一直刪除到沒有字串
    else
    {
        [self __cleanDramas];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    searchBar.showsCancelButton = NO;
    searchBar.text              = nil;
    self.enterSearch            = NO;
    self.searchReslut           = nil;
}

#pragma mark - 下拉更新
- (IBAction)pullToReload:(UIRefreshControl *)sender
{
    self.clicked  = -1;
    
    [[LeanCloud singleton]reloadData:^(NSError *err) {
        if(err)
        {
            self.tableView.tableHeaderView = nil;
            [MGHelper alert:@"錯誤" message:@"查無資料\n請檢查網路連線\n或稍後再試" inMVC:self];
        }
        else
        {
            [self __setupSearchBar];
        }
        
        self.searchReslut = nil;
        [sender endRefreshing];
    }];
}

#pragma mark - 初始設置
- (void)__setup
{
    self.clicked = -1;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    UINib *nib = [UINib nibWithNibName:@"MGDramaHeader" bundle:nil];
    
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"Header"];
}

#pragma mark - reload tableView 並判斷右上收藏 item 是否能點擊
- (void)__reload
{
    [self.tableView reloadData];
    
    if(!self.navigationItem.rightBarButtonItem)
    {
        return;
    }
    
    NSArray *favIds   = [MGHelper favoriteList];
    NSArray *dramaIds = [_dramas valueForKey:@"objectId"];
    
    NSSet *set1 = [NSSet setWithArray:dramaIds];
    NSSet *set2 = [NSSet setWithArray:favIds];
    
    self.navigationItem.rightBarButtonItem.enabled = [set1 intersectsSet:set2];
}

#pragma mark - 設置搜尋
- (void)__setupSearchBar
{
    UISearchBar *searchBar         = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.delegate             = self;
    self.tableView.tableHeaderView = searchBar;
}

#pragma mark - 清除 dramas
- (void)__cleanDramas
{
    self.clicked = -1;
    self.dramas = nil;
    
    [self __reload];
}

#pragma mark - 設置 AdMob
- (void)__setupAdMob
{
    self.banner                    = [[GADBannerView alloc]initWithAdSize:kGADAdSizeBanner];
    self.tableView.tableFooterView = self.banner;
    _banner.adUnitID               = @"ca-app-pub-9003896396180654/4692599394";
    _banner.rootViewController     = self;

    [_banner loadRequest:[GADRequest request]];
}

@end
