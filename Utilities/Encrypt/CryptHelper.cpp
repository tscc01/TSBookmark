//
//  CryptHelper.cpp
//  ST
//
//  Created by YangNan on 15/4/2.
//  Copyright (c) 2015年 HaoYa. All rights reserved.
//

#include "CryptHelper.h"
#include <string>
using namespace std;

CryptHelper::CryptHelper() {
    key = "3213231231232323123";
#ifdef DEBUG
    httpKey = "3213";
#else
    httpKey = "32123";
#endif
}

string CryptHelper::getKey() {
    return key;
}

string CryptHelper::getHttpKey() {
    return httpKey;
}
