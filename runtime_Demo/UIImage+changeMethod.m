//
//  UIImage+changeMethod.m
//  runtime_Demo
//
//  Created by 马金丽 on 17/7/17.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "UIImage+changeMethod.h"
#import <objc/runtime.h>
@implementation UIImage (changeMethod)

+ (void)load
{
    Method oldmethod = class_getClassMethod(self, @selector(imageNamed:));
    Method newmethod = class_getClassMethod(self, @selector(imageOriginalWithStrName:));
    method_exchangeImplementations(newmethod, oldmethod);
    
    
}

+ (id)imageOriginalWithStrName:(NSString *)name
{
    
    UIImage *image = [[self imageOriginalWithStrName:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (image == nil) {
        NSLog(@"图片为空");
    }
    return image;
}


@end
