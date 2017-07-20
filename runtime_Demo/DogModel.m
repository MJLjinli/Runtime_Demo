
//
//  DogModel.m
//  runtime_Demo
//
//  Created by 马金丽 on 17/7/20.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "DogModel.h"
#import <objc/runtime.h>
@interface DogModel()<NSCoding>


@end

@implementation DogModel



-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count =0;
    
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历所有的属性
        for (int i = 0; i < count; i++) {
            //获取当前遍历到的属性名称
            const char *propertyName = property_getName(propertes[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            //解归档前遍历得到的属性的值
            id value = [aDecoder decodeObjectForKey:name];
            //             self.className = [decoder decodeObjectForKey:@"className"];
            [self setValue:value forKey:name];
        }
    } return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i=0; i<count; i++) {
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        id value = [self valueForKey:name];
        //归档到文件中
        [aCoder encodeObject:value forKey:name];
    }
}

@end
