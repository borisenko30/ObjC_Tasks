//
//  IDPMacros.h
//  Task03_ObjC
//
//  Created by Student003 on 5/11/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#define IDPDeclareConstant(type, name) extern type const name;

#define IDPGenerateConstant(type, name, value) type const name = value;
#define IDPGenerateConstantRange(name, value1, value2) NSRange const name = { value1, value2 };

#define IDPStaticConstant(type, name, value) static type const name = value;
#define IDPStaticConstantRange(name, value1, value2) static NSRange const name = { value1, value2 };
