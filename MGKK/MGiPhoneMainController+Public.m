// MGiPhoneMainController+Public.m
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

#import "MGiPhoneMainController+Public.h"


@implementation MGiPhoneMainController (Public)

#pragma mark - UIStoryboardSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toFetch"])
    {
        // to 查詢影片來源 ( MGFetchViewController )
        NSIndexPath *indexPath     = [self.tableView indexPathForSelectedRow];
        AVObject *drama            = self.dramas[indexPath.section];
        NSArray *data              = drama[@"data"];
        MGFetchViewController *mvc = segue.destinationViewController;
        mvc.delegate               = self;
        mvc.fetchURL               = data[indexPath.row];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.clicked == section)
    {
        AVObject *drama = self.dramas[section];
        NSArray *array  = drama[@"data"];
        
        return [array count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text   = [NSString stringWithFormat:@"第 %ld 集", (long)indexPath.row + 1];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MGDramaHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    
    header.tag      = section;
    header.delegate = self;
    AVObject *drama = self.dramas[section];
    
    [header configureDrama:drama withColor:self.headerColor];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}

#pragma mark - MGDramaHeaderDelegate
- (void)header:(MGDramaHeader *)header didClickedAtSection:(NSInteger)section
{
    [self.tableView.tableHeaderView resignFirstResponder];
    
    if(section == self.clicked)
    {
        // 縮起來
        self.clicked = -1;
    }
    else
    {
        // 展開
        self.clicked = section;
    }
    
    [self.tableView reloadData];
}

#pragma mark - MGFetchViewControllerDelegate
- (void)mvc:(MGFetchViewController *)mvc didFetchedVideo:(NSURL *)url
{
    [mvc dismissViewControllerAnimated:NO completion:^{
        if(url)
        {
            [MGHelper playVideo:url inMVC:self];
        }
        else
        {
             NSString *message = @"讀取影片來源失敗\n請稍候再試\n或是回報作者";
             
            [MGHelper alert:@"錯誤" message:message inMVC:self];
        }
    }];
}

@end
