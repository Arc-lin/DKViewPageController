//
//  AppDelegate.m
//  DKViewPagerDemo
//
//  Created by Arclin on 16/4/18.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "AppDelegate.h"
#import "DKViewPagerController.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    ViewController2 *vc3 = [[ViewController2 alloc] init];
    DKViewPagerController *vc = [[DKViewPagerController alloc] initWithPageTitles:@[@"视图1",@"视图2",@"视图3"] controllers:@[vc1,vc2,vc3]];
    vc.highlightColor = [UIColor redColor];
    vc.titleViewBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    vc.normalColor = [UIColor grayColor];
    window.rootViewController = vc;
    
    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
