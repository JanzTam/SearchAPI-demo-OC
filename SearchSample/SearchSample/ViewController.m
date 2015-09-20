//
//  ViewController.m
//  SearchSample
//
//  Created by tangjianzhuo on 15/9/20.
//  Copyright © 2015年 JanzTam. All rights reserved.
//

#import "ViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>//kUTTypeImage使用到

#define tUniqueIdentifier  @"com.tam.searchSample"//搜索唯一标示
#define tDomainIdentifier  @"searchapis"

@interface ViewController ()
{
    NSUserActivity * activity;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSUserActivity
    NSString * activityType = [NSString stringWithFormat:@"%@.%@", tUniqueIdentifier, tDomainIdentifier];
    activity = [[NSUserActivity alloc] initWithActivityType:activityType];
    activity.title    = @"快快搜索_NSUserActivity";
    activity.keywords = [[NSSet alloc]initWithObjects:@"租车", @"快快", @"旅游", @"汽车",@"宝马", nil];
    activity.eligibleForSearch = true;
    [activity becomeCurrent];
    
    
    // Core Spotlight
    CSSearchableItemAttributeSet * attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(__bridge id)kUTTypeImage];
    attributeSet.title = @"我要租车";
    attributeSet.contentDescription = @"要快，就现在！";
    attributeSet.keywords = [[NSArray alloc]initWithObjects:@"租车", @"快快", @"旅游", @"汽车",@"宝马",@"奔驰",@"快快租车",@"奥迪",@"美女",@"约会", nil];
    UIImage * image = [UIImage imageNamed:@"car"];
    NSData  * data  = UIImagePNGRepresentation(image);
    attributeSet.thumbnailData = data;
    
    
    CSSearchableItem * searchableItem = [[CSSearchableItem alloc] initWithUniqueIdentifier:tUniqueIdentifier
                                                                          domainIdentifier:tDomainIdentifier
                                                                              attributeSet:attributeSet];
    //可添加多个CSSearchableItemAttributeSet，根据定义不同的关键字和图片,自由组成不同搜索组合
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[searchableItem]
                                                   completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"failed with error:\(error)\n");
        }
        else {
            NSLog(@"succ!\n");
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
