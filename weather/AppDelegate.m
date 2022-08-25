//
//  BNRAppDelegate.m
//  HomePwner
//
//  Created by John Gallagher on 1/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "AppDelegate.h"
#import "forecastSevenDaysViewController.h"
#import "weatherLiveViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    //weatherLiveVc
    weatherLiveViewController *liveVC = [weatherLiveViewController new];
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"天气实况"
                                                        image:[UIImage imageNamed:@"icons8-clouds-30.png"]
                                                selectedImage:[UIImage imageNamed:@"icons8-clouds-30.png"]];
    liveVC.tabBarItem = item5;
    
    //vc for weather
    forecastSevenDaysViewController *vcWeather = [forecastSevenDaysViewController new];
    UINavigationController *weatherNavController = [[UINavigationController alloc]
                                             initWithRootViewController:vcWeather];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"天气预报"
                                                        image:[UIImage imageNamed:@"icons8-clouds-30.png"]
                                                selectedImage:[UIImage imageNamed:@"icons8-clouds-30.png"]];
    weatherNavController.tabBarItem = item4;

    
    //add all VC to tabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[weatherNavController, liveVC];
    // Place navigation controller's view in thvcWeathere window hierarchy
    self.window.rootViewController = tabBarController;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
