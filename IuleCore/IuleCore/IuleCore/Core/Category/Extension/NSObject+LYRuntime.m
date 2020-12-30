//
//  NSObject+LYRuntime.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NSObject+LYRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (LYRuntime)

/**
 获取对象所有属性
 
 @return return value description
 */
- (NSArray *)ly_getAllProperties {
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:0];
    
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        [propertiesArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    // You must free the array with free().
    free(properties);
    return propertiesArray;
}

/**
 获取对象所有方法
 
 @return return value description
 */
- (NSArray *)ly_getAllMethods {
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:0];
    
    unsigned int count;
    
    Method *methodList = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        Method temp = methodList[i];
        //        IMP imp = method_getImplementation(temp);
        //        SEL name_f = method_getName(temp);
        const char* name_s = sel_getName(method_getName(temp));
        //        int arguments = method_getNumberOfArguments(temp);
        //        const char* encoding = method_getTypeEncoding(temp);
        //        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
        //              arguments,
        //              [NSString stringWithUTF8String:encoding]);
        [methodsArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    free(methodList);
    return methodsArray;
}

/**
 获取对象的所有属性和属性内容
 
 @return return value description
 */
- (NSDictionary *)ly_getAllPropertiesAndVaules {
    NSMutableDictionary *propsDic = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for ( int i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [propsDic setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return propsDic;
}

@end
