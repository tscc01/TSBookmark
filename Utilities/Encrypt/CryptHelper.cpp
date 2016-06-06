//
//  CryptHelper.cpp
//  ST
//
//  Created by YangNan on 15/4/2.
//  Copyright (c) 2015年 Teng Niu. All rights reserved.
//

#include "CryptHelper.h"
#include <string>
using namespace std;

CryptHelper::CryptHelper() {
    key = "31c1d42965c893942be9e44033eaf370";
#ifdef DEBUG
    httpKey = "111111";
#else
    httpKey = "11";
#endif
}

string CryptHelper::getKey() {
    return key;
}

string CryptHelper::getHttpKey() {
    return httpKey;
}