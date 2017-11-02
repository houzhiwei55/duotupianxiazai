//
//  ViewController.m
//  理解-多图片下载
//
//  Created by apple on 2017/10/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "WJApp.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<UITableViewDataSource>
//tableView的数据源
@property(nonatomic, strong) NSArray *apps;

/**
 内存缓存
 */
@property(nonatomic, strong) NSMutableDictionary *images;

//操作缓存
@property(nonatomic, strong) NSMutableDictionary  *operations;

@property(nonatomic, strong) NSOperationQueue *queue;




@end

@implementation ViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [SDWebImageManager sharedManager];
}

#pragma mark - layloading
-(NSArray *)apps
{
    if (_apps == nil) {
        //加载数据
        NSArray *arrayM = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"apps.plist" ofType:nil]];
        
        
        //字典转模型
        NSMutableArray *appArrayM = [NSMutableArray arrayWithCapacity:arrayM.count];
        
        for (NSDictionary *dict in arrayM) {
            [appArrayM addObject:[WJApp appWithDict:dict]];
            
        }
        _apps = appArrayM;
        NSLog(@"%@",appArrayM);
    }
    return _apps;
}

-(NSMutableDictionary *)images
{
    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;

}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}


/**
 显示

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    WJApp *app = self.apps[indexPath.row];
    
    //设置数据
    
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:app.icon] placeholderImage:[UIImage imageNamed:@"123"]];
    
    /**
     第一个参数：要下载图片的地址
     第二个参数：站位图片
     第三个参数：下载图片的策略
     第四个参数：progress是一个block, 监听下载进度 
     receivedSize:已经下载的大小
     expectedSize:图片大小
     第五个参数：下载完成后调用

     */
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:app.icon] placeholderImage:[UIImage imageNamed:@"123"] options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"%.2f",1.0 * receivedSize / expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"已经完成了");
    }];
    
    return cell;

    
//    
//    UIImage *image = [self.images objectForKey:app.icon];
//    if (image) {
//        cell.imageView.image = image;
//    }else{
//        //缓存路径
//        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        
//        //文件名
//        NSString *fileName = [app.icon lastPathComponent];
//        
//        //拼接文件全路径
//        NSString *fullPath = [caches stringByAppendingPathComponent:fileName];
//        
//        NSLog(@"%@",fullPath);
//        
//        NSData *data = [NSData dataWithContentsOfFile:fullPath];
//        
//        if (data) {
//            UIImage *image = [UIImage imageWithData:data];
//            cell.imageView.image = image;
//            //保存到内存缓存
//            [self.images setObject:image forKey:app.icon];
//        }else
//        {
//            NSURL *url = [NSURL URLWithString:app.icon];
//            NSData *data = [NSData dataWithContentsOfURL:url];
//            UIImage *image = [UIImage imageWithData:data];
//            cell.imageView.image = image;
//            //保存到内存缓存
//            [self.images setObject:image forKey:app.icon];
//            NSLog(@"%zd",indexPath.row);
//            
//            //保存到沙盒
//            [data writeToFile:fullPath atomically:YES];
//
//            
//        }
    
        

//    }

    
    
    

}

/*
 Documents:数据会备份，
 Library
    caches
    perference
 tmp:临时文件夹.
 */

/*
 1.很卡，会卡住主线程--->开子线程下载
 2.重复下载
 */


-(void)didReceiveMemoryWarning
{
    self.images = nil;
    self.operations = nil;
    [self.queue cancelAllOperations];
    
}
@end
