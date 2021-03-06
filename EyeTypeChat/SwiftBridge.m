//
//  SwiftBridge.m
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 9/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

void performSelectorInObject(id target, SEL selector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [target performSelector:selector];
#pragma clang diagnostic pop
}
