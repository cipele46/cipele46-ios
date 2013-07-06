//
//  C46AppDelegate.m
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46AppDelegate.h"

#import "C46HomeTabBarController.h"
#import "C46FacebookConnect.h"

@interface C46AppDelegate ()

@property (strong, nonatomic) C46HomeTabBarController *homeTabBarController;

@end

@implementation C46AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.homeTabBarController = [[C46HomeTabBarController alloc] init];
    self.window.rootViewController = self.homeTabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[C46FacebookConnect sharedInstance] handleOpenURL:url];
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    [[C46FacebookConnect sharedInstance] handleDidBecomeActive];
}

@end
