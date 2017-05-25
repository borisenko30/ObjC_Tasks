//
//  Task06_Tests.m
//  Task06_Tests
//
//  Created by Student003 on 5/17/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "Kiwi.h"

#import "IDPCar.h"
#import "IDPWasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"

#import "NSObject+IDPExtensions.h"

SPEC_BEGIN(Task06_Test)

describe(@"IDPWorkerDelegate", ^{
    
    context(@"when washer did finish work", ^{
        __block IDPWasher *washer;
        __block IDPCar *car;
        
        beforeAll(^{ // Occurs once
            car = [IDPCar object];
            washer = [IDPWasher object];
        });
        
        afterAll(^{ // Occurs once
            washer = nil;
            car = nil;
        });
        
        it(@"carWaher should receive -delegatingObjectDidGetMoney", ^{
            [[washer shouldNot] receive:@selector(workerDidBecomeReadyForProcessing:)];
            [washer processObject:car];
        });
        
        context(@"when accountant did his work", ^{
            __block IDPDirector *director;
            __block IDPAccountant *accountant;
            
            beforeAll(^{ // Occurs once
                accountant = [IDPAccountant object];
                director = [IDPDirector object];
                accountant.delegate = director;
            });
            
            afterAll(^{ // Occurs once
                director = nil;
                accountant = nil;
            });
            
            it(@"accountant should receive -delegatingObjectDidGetMoney", ^{
                [[director should] receive:@selector(workerDidBecomeReadyForProcessing:)];
                [accountant processObject:washer];
            });
        });
    });
});

SPEC_END
