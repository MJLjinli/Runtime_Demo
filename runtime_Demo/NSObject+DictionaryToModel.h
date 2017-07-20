//
//  NSObject+DictionaryToModel.h
//  runtime_Demo
//
//  Created by 马金丽 on 17/7/17.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import <Foundation/Foundation.h>


//字典转模型
@interface NSObject (DictionaryToModel)

+ (instancetype)transformToModelWithDictionary:(NSDictionary *)dict;

@end
