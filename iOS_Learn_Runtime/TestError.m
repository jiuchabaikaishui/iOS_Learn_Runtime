//
//  TestError.m
//  Runtime_Learn
//
//  Created by 綦 on 16/8/12.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "TestError.h"
#import <objc/runtime.h>
#import <objc/message.h>

void TestMetaClass(id self, SEL _cmd)
{
    {
        // self 指实例自身地址 == id instance
        NSLog(@"这个对象是：%p", self);
        /*
         class 方法实现 return object_getClass(self)
         class方法其实取到传入对象（self）的isa对象而已 self的isa 指向类对象！ %@就会打印类对象的 description 方法
         superclass 方法实现 return [self class]的superclass
         同理 self class 取到类对象 然后取到superclass %@就会打印类对象的 description 方法
         */
        NSLog(@"类是：%@,父类是：%@", [self class], [self superclass]);
    
        // self是实例对象 因此self的isa 取到类对象
        Class currentClass = [self class];
    
        /*
         现在结构是 NSObject->NSError->TestError
         */
        for (int index = 0; index < 4; index++) {
            //第0次 currentClass 是TestError类对象
            //第1次 currentClass 是TestError 的 metaClass
            //第2次 currentClass 是NSObject 的 metaClass(因为metaClass的isa都是指向基类NSObject的metaClass)
            //第3次 currentClass 是NSObject 的metaClass 是自身。。。。。。正如图所示
            NSLog(@"第%i级isa指针：%p", index, currentClass);
    
            // 其实是对传入对象的isa
            currentClass = object_getClass(currentClass);
        }
    
        // 图说 NSObject metaClass的superClass 是NSObject类对象！ 测试下
        NSLog(@"NSObject's class is %p (get by NSObject metaClass superClass)",[currentClass superclass]);
        
        // 直接取到NSObject的类对象
        NSLog(@"NSObject 的 Class 是：%p", [NSObject class]);
        NSLog(@"NSObject 的 metaClass 是：%p", object_getClass([NSObject class]));
    }
    {
//        NSLog(@"这个对象是:%p", self);
//        NSLog(@"此对象的类是:%p, 父类是:%p", [self class], [self superclass]);
//        
//        Class currentClass = [self class];
//        for (int index = 0; index < 4; index++) {
//            NSLog(@"第%i次isa指针是:%p", index, currentClass);
//            currentClass = objc_getClass((__bridge void *)currentClass);
//        }
//        
//        NSLog(@"NSObject的类是:%p", [NSObject class]);
//        NSLog(@"NSObject的元类是:%p", objc_getClass((__bridge void *)[NSObject class]));
    }
}

@implementation TestError

- (void)ex_registerClassPair
{
    /**
     步骤：
     1. objc_allocateClassPair 想要获得metaclass 使用object_getClass(newClass)
     2. 往新增类中添加属性class_addMethod class_addIvar
     3. 最后objc_registerClassPair注册 这样newClass可以使用了
     NOTE:newClass仅仅只是一个类对象 class object 而不是一个类实例！！！
     */
    Class newClass = objc_allocateClassPair([TestError class], "TestErrorClass", 0);//注意：第二个参数是类的名称，不能与现有类冲突
    if (newClass == nil) {
        NSLog(@"newClass为空");
    }
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    objc_registerClassPair(newClass);
    
    // 实例化对象 id typedef struct objc_object *id
    // 而类是typedef struct objc_class *Class
    // Class object 同样是一个对象 所以继承自 objc_object
    
    // 接下来实例化一个对象
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    //TestMetaClass是具体实现函数地址 而testMetaClass 只是方法名字
    [instance performSelector:@selector(testMetaClass)];
}

@end
