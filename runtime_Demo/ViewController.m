//
//  ViewController.m
//  runtime_Demo
//
//  Created by 马金丽 on 17/7/17.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "ViewController.h"
#import "PersonModel.h"
#import "PersonModel+addAttribute.h"
#import "UIImage+changeMethod.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+DictionaryToModel.h"
#import "DogModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PersonModel *model = [[PersonModel alloc]init];
    model.name = @"卡卡";
    model.age = @"8";
    NSLog(@"%@--%@",model.name,model.age);
//    [model run];
    //发送消息
    ((void(*) (id,SEL)) (void *)objc_msgSend)(model,@selector(run));
    //交换方法
//    UIImage *image = [UIImage imageNamed:@""];
    //动态的添加方法并调用
//    [model performSelector:@selector(jump)withObject:@"bbbb"];
    
//    [self getAllIvars];
//    [self getALLproperty];
//    [self getAllMethod];
    NSDictionary *dic = @{@"name":@"小红",@"classid":@"1101"};
    PersonModel *p2 = [PersonModel transformToModelWithDictionary:dic];
    NSLog(@"%@",p2.name);
    
    
    DogModel *dog1 = [[DogModel alloc]init];
    dog1.name = @"萨摩耶";
    dog1.age = @"1";
    dog1.sex = @"nv";
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    filePath = [filePath stringByAppendingPathComponent:@"modelPath.plist"];
    [NSKeyedArchiver archiveRootObject:dog1 toFile:filePath];
   DogModel *dog = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",filePath);
    NSLog(@"%@",dog.name);

}


//获取所有成员变量(.h和.m)(成员变量+属性)
- (void)getAllIvars
{
    PersonModel *person = [[PersonModel alloc] init];
    person.name = @"啦啦";
    person.age = @"9";
    
    unsigned int count = 0;
    Ivar *iavrs = class_copyIvarList([PersonModel class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Ivar ivar = iavrs[i];
        NSLog(@"成员变量%@/n获取成员变量的数据类型%@",[NSString stringWithUTF8String:ivar_getName(ivar)],[NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)]);
    }
    Ivar ivar = class_getInstanceVariable([PersonModel class], "_height");
    object_setIvar(person, ivar, @"180");
    NSLog(@"修改后的name:%@",object_getIvar(person, ivar));
    
}

//获取所有属性(仅仅是属性包括动态添加的)
- (void)getALLproperty
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([PersonModel class], &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        const char *propertyDes = property_getAttributes(property);
        NSLog(@"属性名:%s 属性类型%s",name,propertyDes);
    }
}

//获取对象的所有方法
- (void)getAllMethod
{
    PersonModel *person = [[PersonModel alloc]init];
    [person like:@"篮球"];

    unsigned int count = 0;
    Method *methods = class_copyMethodList([PersonModel class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSString *methodName = NSStringFromSelector(sel);
        if ([methodName isEqualToString:@"like:"]) {
        }
        NSLog(@"获取对象的方法:%@",methodName);
    }
}


- (void)message
{
    NSLog(@"发送消息");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
