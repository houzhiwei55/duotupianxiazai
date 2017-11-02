//
//  WJApp.m
//  理解-多图片下载
//
//  Created by apple on 2017/10/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WJApp.h"

@implementation WJApp
+(instancetype)appWithDict:(NSDictionary *)dict
{
    WJApp *app = [[WJApp alloc] init];
    [app setValuesForKeysWithDictionary:dict];
    
    return app;
}


@end
