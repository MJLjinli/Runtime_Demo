//
//  NSObject+DictionaryToModel.m
//  runtime_Demo
//
//  Created by 马金丽 on 17/7/17.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "NSObject+DictionaryToModel.h"
#import <objc/runtime.h>
@implementation NSObject (DictionaryToModel)

+ (instancetype)transformToModelWithDictionary:(NSDictionary *)dict
{
    //获取所有属性的值
    unsigned int count = 0;
    objc_property_t *propertiesList = class_copyPropertyList([self class], &count);
    NSMutableArray *listArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertiesList[i];
        const char *propertyName = property_getName(property);
        NSString *pName = [NSString stringWithUTF8String:propertyName];
        [listArray addObject:pName];
    }
    //释放属性数组
    free(propertiesList);
    id obj = [self new];
    for (NSString *proName in listArray) {
        if ([dict objectForKey:proName]) {
            [obj setValue:[dict objectForKey:proName] forKey:proName];
        }
    }
    return obj;
}


@end
