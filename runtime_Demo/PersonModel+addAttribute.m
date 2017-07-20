//
//  PersonModel+addAttribute.m
//  runtime_Demo
//
//  Created by 马金丽 on 17/7/17.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "PersonModel+addAttribute.h"
#import <objc/runtime.h>



@implementation PersonModel (addAttribute)
static char *PersonAgeKey = "PersonAgeKey";

- (void)setAge:(NSString *)age
{
    /**
     关联属性

     @param id object 给哪个对象的属性赋值
     @param const void *key 属性对应的key
     @param id value 设置属性的值
     @param objc_AssociationPolicy policy 使用的策略 
     @return
     */
    objc_setAssociatedObject(self, PersonAgeKey,age , OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)age
{
    //获取关联属性
    return objc_getAssociatedObject(self, PersonAgeKey);
}


//动态添加方法
- (void)jump
{
    NSLog(@"一个人在跳");
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(jump)) {
        class_addMethod(self, sel, class_getMethodImplementation(self, @selector(jump)), "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

@end
