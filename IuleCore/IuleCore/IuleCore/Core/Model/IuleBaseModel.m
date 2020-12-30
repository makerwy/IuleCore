//
//  IuleBaseModel.m
//  IuleCore
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 iule. All rights reserved.
//

#import "IuleBaseModel.h"
#import <objc/runtime.h>

@implementation IuleBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@模型中没有%@属性字段",NSStringFromClass([self class]),key);
}

- (NSDictionary *)iule_keyValues {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);

    for (int i = 0; i < count; i++) {
       objc_property_t property = propertyList[i];
       const char *cName = property_getName(property);
       NSString *name = [NSString stringWithUTF8String:cName];
       NSObject *value = [self valueForKey:name];//valueForKey返回的数字和字符串都是对象

       if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
           //string , bool, int ,NSinteger
           [dic setObject:value forKey:name];
       } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
           //字典或字典
           [dic setObject:[self arrayOrDicWithObject:value] forKey:name];
       } else if (value == nil) {
           //null
           //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
       } else {
           //model
           [dic setObject:[self iule_keyValues] forKey:name];
       }
    }
    return [dic copy];
}

//将可能存在model数组转化为普通数组
- (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
            } else {
                //model
                [array addObject:[self iule_keyValues]];
            }
        }
        return [array copy];
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        //字典
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
            } else {
                //model
                [dic setObject:[self iule_keyValues] forKey:key];
            }
        }
        return [dic copy];
    }
    return [NSNull null];
}

@end
