//
//  Task06_Tests.m
//  Task06_Tests
//
//  Created by Student003 on 5/17/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "Kiwi.h"

#import "IDPCarWasher.h"
#import "IDPAccountant.h"

#import "IDPConstants.h"
#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"

SPEC_BEGIN(Task06_Test)

describe(@"IDPWorkerDelegate", ^{
    __block IDPCarWasher *carWasher;
    __block IDPAccountant *accountant;
    
    context(@"a state the component is in", ^{
   
        beforeAll(^{ // Occurs once
            carWasher = [IDPCarWasher object];
            accountant = [IDPAccountant object];
        });
        
        afterAll(^{ // Occurs once
            carWasher = nil;
            accountant = nil;
        });
        
        it(@"should do something", ^{
            NSUInteger money = IDPRandomWithRange(IDPCashRange);
            
        });
        

    });
});

SPEC_END
