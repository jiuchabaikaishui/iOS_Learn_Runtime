//
//  MyClass.m
//  iOS_Learn_Runtime
//
//  Created by 綦 on 16/8/16.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "MyClass.h"

@interface MyClass ()
{
    NSInteger _instance;
    NSString *_instance1;
}
@property (assign, nonatomic) NSInteger integer;

- (void)method2:(NSInteger)integer and:(NSString *)str;

@end

@implementation MyClass

+ (void)classMethod
{
    NSLog(@"%s", __FUNCTION__);
}
- (void)method
{
    NSLog(@"%s", __FUNCTION__);
}
- (void)method1
{
    NSLog(@"%s", __FUNCTION__);
}
- (void)method2:(NSInteger)integer and:(NSString *)str
{
    NSLog(@"%s", __FUNCTION__);
}

@end
