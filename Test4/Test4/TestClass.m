//
//  TestClass.m
//  Test4
//
//  Created by FineexMac on 16/3/17.
//  Copyright © 2016年 iOS_Liu. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass


+ (TestClass *)share
{
    static TestClass *class = nil;
    if (class == nil) {
        class = [[TestClass alloc] init];
        NSLog(@"----%@", class);
    }
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        class = [[TestClass alloc] init];
//        NSLog(@"----%@", class);
//    });
    return class;
}

@end
