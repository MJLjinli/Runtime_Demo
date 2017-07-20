//
//  PersonModel.m
//  runtime_Demo
//
//  Created by 马金丽 on 17/7/17.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "PersonModel.h"
#import <objc/runtime.h>
@interface PersonModel()
{
//    NSString *_height;
}

@property(nonatomic,strong)NSMutableDictionary *dict;

@end


@implementation PersonModel


- (void)run
{
    NSLog(@"一个人正在跑");
}


- (void)like:(NSString *)likeStr
{
    NSLog(@"爱好是:%@",likeStr);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        
        
    }
    return self;
}





@end
