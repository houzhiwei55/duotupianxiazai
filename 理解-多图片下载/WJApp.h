//
//  WJApp.h
//  理解-多图片下载
//
//  Created by apple on 2017/10/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJApp : NSObject
@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSString *icon;

@property(nonatomic, strong) NSString *download;


+(instancetype)appWithDict:(NSDictionary *)dict;

@end
