//
//  PersonModel.h
//  runtime_Demo
//
//  Created by 马金丽 on 17/7/17.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject
{
//    NSString *_sex;
}
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *classid;


- (void)run;

- (void)like:(NSString *)likeStr;



@end
