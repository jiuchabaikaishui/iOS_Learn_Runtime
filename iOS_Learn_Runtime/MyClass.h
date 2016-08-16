//
//  MyClass.h
//  iOS_Learn_Runtime
//
//  Created by 綦 on 16/8/16.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject
@property (strong, nonatomic) NSArray *array;
@property (copy, nonatomic) NSString *string;

+ (void)classMethod;
- (void)method;
- (void)method1;

@end
