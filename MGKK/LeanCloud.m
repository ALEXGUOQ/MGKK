// LeanCloud.m
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


@interface LeanCloud ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end


@implementation LeanCloud

#pragma mark - LifeCycle
+ (instancetype)singleton
{
    static dispatch_once_t onceToken;
    static LeanCloud *_singleton;
    
    dispatch_once(&onceToken, ^{
        _singleton = [[LeanCloud alloc]init];
        _singleton.dataSource = [NSMutableArray array];
    });
    
    return _singleton;
}

#pragma mark - Properties Getter
- (NSArray *)dramas
{
    return _dataSource;
}

#pragma mark - Reload
- (void)reloadData:(void (^)(NSError *))complete
{
    [_dataSource removeAllObjects];
    
    NSString *sql = @"select * from Dramas where enable = true order by name DESC";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSError *error;
        AVCloudQueryResult *result = [AVQuery doCloudQueryWithCQL:sql error:&error];
        
        [_dataSource addObjectsFromArray:result.results];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(complete)
            {
                complete(error);
            }
        });
    });
}

@end
