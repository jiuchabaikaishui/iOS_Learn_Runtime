//
//  ViewController.m
//  iOS_Learn_Runtime
//
//  Created by 綦 on 16/8/16.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "ViewController.h"
#import "TestError.h"
#import "MyClass.h"
#import <objc/objc-class.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    TestError *error = [TestError errorWithDomain:@"QSP domain" code:1 userInfo:nil];
//    [error ex_registerClassPair];
    
    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0;
    
    Class cls = myClass.class;
    
    //类名
    NSLog(@"类名：%s", class_getName(cls));
}

@end
