// AppDelegate.m
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
#import "AppDelegate.h"


@implementation AppDelegate

#pragma mark - LifeCycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:
(NSDictionary *)launchOptions
{
    [self __setup];
    [self __setupLeanCloud];
    [_window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 初始
- (void)__setup
{
    // 不使用 UIStoryboard 當 Main Window
    CGRect rect         = [[UIScreen mainScreen]bounds];
    UIWindow *window    = [[UIWindow alloc]initWithFrame:rect];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UISplitViewController *rootViewController = [[UISplitViewController alloc]init];
    id masterViewController;
    id detailViewController = [story instantiateViewControllerWithIdentifier:@"Noti"];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        masterViewController = [story instantiateViewControllerWithIdentifier:@"iPad"];
    }
    else
    {
        masterViewController = [story instantiateViewControllerWithIdentifier:@"iPhone"];
    }
    
    rootViewController.viewControllers      = @[masterViewController, detailViewController];
    rootViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    
    window.rootViewController = rootViewController;
    self.window = window;
}

#pragma mark - 設置 LeanCloud
- (void)__setupLeanCloud
{
#error Input your kye
    [AVOSCloud setApplicationId:@"Your App Id"
                      clientKey:@"Your Client key"];
}

@end
