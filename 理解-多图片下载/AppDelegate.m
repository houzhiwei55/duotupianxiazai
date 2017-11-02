//
//  AppDelegate.m
//  理解-多图片下载
//
//  Created by apple on 2017/10/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //1.取消当前所有任务
    [[SDWebImageManager sharedManager] cancelAll];
    

}


@end
