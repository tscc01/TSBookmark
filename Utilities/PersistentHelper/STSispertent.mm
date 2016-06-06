//
//  STSispertent.m
//  TengNiu
//
//  Created by 李晓春 on 16/5/25.
//  Copyright © 2016年 Teng Niu. All rights reserved.
//

#import "STSispertent.h"
#import "STSistentModel.hpp"


@interface STSispertent () {
    STSistentModel* _sistent;
}

@end

@implementation STSispertent

+ (instancetype)sharedInstance
{
    static STSispertent* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [STSispertent new];
    });
    
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _sistent = new STSistentModel();
    }
    return self;
}

- (NSString *)stSispertent {
    return [NSString stringWithCString:_sistent->getSistent().c_str() encoding:NSUTF8StringEncoding];
}

@end
