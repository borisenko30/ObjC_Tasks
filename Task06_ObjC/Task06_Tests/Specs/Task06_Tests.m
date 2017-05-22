//
//  Task06_Tests.m
//  Task06_Tests
//
//  Created by Student003 on 5/17/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "Kiwi.h"

#import "IDPCar.h"
#import "IDPCarWasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"

#import "NSObject+IDPExtensions.h"

SPEC_BEGIN(Task06_Test)

describe(@"IDPWorkerDelegate", ^{
    
    context(@"when carWasher received money", ^{
        __block IDPCarWasher *carWasher;
        __block IDPCar *car;
        
        beforeAll(^{ // Occurs once
            car = [IDPCar object];
            carWasher = [IDPCarWasher object];
            car.delegate = carWasher;
        });
        
        afterAll(^{ // Occurs once
            carWasher = nil;
            car = nil;
        });
        
        it(@"delegate should receive -delegatingObjectDidGetMoney", ^{
            [[carWasher should] receive:@selector(delegatingObjectDidGetMoney:)];
            [car payForCarWash];
        });
        
        context(@"when accountant did his work", ^{
            __block IDPAccountant *accountant;
            __block IDPDirector *director;
            
            beforeAll(^{ // Occurs once
                accountant = [IDPAccountant object];
                director = [IDPDirector object];
                accountant.delegate = director;
            });
            
            afterAll(^{ // Occurs once
                director = nil;
                accountant = nil;
            });
            
            it(@"delegate should receive -delegatingObjectDidGetMoney", ^{
                [[director should] receive:@selector(delegatingObjectDidGetMoney:)];
                [accountant processObject:carWasher];
            });
        });
    });
});

SPEC_END
