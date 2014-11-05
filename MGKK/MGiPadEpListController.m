// MGiPadEpListController.m
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
#import "MGFetchViewController.h"
#import "MGiPadEpListController.h"


@interface MGiPadEpListController ()<MGFetchViewControllerDelegate>

@end


@implementation MGiPadEpListController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _drama[@"name"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toFetch"])
    {
        // to 查詢影片來源 ( MGFetchViewController )
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        NSArray *data              = _drama[@"data"];
        MGFetchViewController *mvc = segue.destinationViewController;
        mvc.delegate               = self;
        mvc.fetchURL               = data[indexPath.row];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *data = _drama[@"data"];
    
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text   = [NSString stringWithFormat:@"第 %ld 集", (long)indexPath.row + 1];
    
    return cell;
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
