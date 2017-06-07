//
//  IDPEnterprise.m
//  Task03_ObjC
//
//  Created by Admin on 09.05.17.
//  Copyright (c) 2017 Student003. All rights reserved.
//

#import "IDPEnterprise.h"

#import "IDPWorker.h"
#import "IDPWasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"
#import "IDPCar.h"

#import "IDPQueue.h"
#import "IDPCarDispatcher.h"
#import "IDPDispatcher.h"

#import "IDPMacros.h"

#import "NSObject+IDPExtensions.h"
#import "NSMutableArray+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

IDPStaticConstant(NSUInteger, IDPWashersCount, 5)
IDPStaticConstant(NSUInteger, IDPAccountantsCount, 2)
IDPStaticConstant(NSUInteger, IDPDirectorsCount, 1)


typedef id(^IDPDispatcherFactory)(Class handlerClass, NSUInteger handlerCount, id observer);

@interface IDPEnterprise ()
@property (nonatomic, retain) NSArray           *washers;
@property (nonatomic, retain) NSArray           *accountants;
@property (nonatomic, retain) IDPDirector       *director;
@property (nonatomic, retain) IDPDispatcher     *washersDispatcher;
@property (nonatomic, retain) IDPDispatcher     *accountantsDispatcher;
@property (nonatomic, retain) IDPDispatcher     *directorsDispatcher;

@end

@implementation IDPEnterprise

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.washers = nil;
    self.accountants = nil;
    self.director = nil;
    self.washersDispatcher = nil;
    self.accountantsDispatcher = nil;
    self.directorsDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.washersDispatcher = [IDPDispatcher object];
    self.accountantsDispatcher = [IDPDispatcher object];
    self.directorsDispatcher = [IDPDispatcher object];
    self.accountants = [NSArray array];
    self.director = [IDPDirector object];
    self.washers = [NSArray array];
    [self assignWorkers];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setWashers:(NSArray *)washers {
    if (washers == _washers) {
        return;
    }
    
    NSArray *observers = @[self.washersDispatcher, self.accountantsDispatcher];
    
    for (IDPWorker *washer in _washers) {
        [washer removeObservers:observers];
    }
    
    [washers retain];
    [_washers release];
    _washers = washers;
}

#pragma mark -
#pragma mark Public

// entry point
- (void)washCars:(NSArray *)cars {
    for (IDPCar *car in cars) {
        [self washCar:car];
    }
}

- (void)washCar:(IDPCar *)car {
    [self.washersDispatcher processObject:car];
}

#pragma mark -
#pragma mark WorkerObserver methods
//
//- (void)workerDidBecomeReadyForProcessing:(id)worker {
//    [self.accountantsDispatcher processObject:worker];
//}

#pragma mark -
#pragma mark Private

- (void)assignWorkers {
    IDPDispatcherFactory factory = ^id(Class handlerClass, NSUInteger handlerCount, id observer){
        id dispatcher = [IDPDispatcher object];
        id handlers = [NSArray objectsWithCount:handlerCount factoryBlock:^id{
            id handler = [handlerClass object];
            [handler addObserver:observer];
            return handler;
        }];
        
        [dispatcher initWithHandlers:handlers];
        
        return dispatcher;
    };
    
    IDPDispatcher *directorsDispatcher = factory([IDPDirector class], IDPDirectorsCount, nil);
    IDPDispatcher *accountantsDispatcher = factory([IDPAccountant class], IDPAccountantsCount, directorsDispatcher);
    IDPDispatcher *washersDispatcher = factory([IDPWasher class], IDPWashersCount, accountantsDispatcher);
    
    self.directorsDispatcher = directorsDispatcher;
    self.accountantsDispatcher = accountantsDispatcher;
    self.washersDispatcher = washersDispatcher;
    
//    self.accountants = [NSArray objectsWithCount:IDPAccountantsCount factoryBlock:^{
//        IDPAccountant *accountant = [IDPAccountant object];
//        [accountant addObservers:@[self.director, self.accountantsDispatcher]];
//        
//        return accountant;
//    }];
//
//    self.washers = [NSArray objectsWithCount:IDPWashersCount factoryBlock:^{
//        IDPWasher *washer = [IDPWasher object];
//        [washer addObservers:@[self.washersDispatcher, self]];
//        
//        return washer;
//    }];
//
    
//    [self.washersDispatcher initWithHandlers:self.washers];
//    [self.accountantsDispatcher initWithHandlers:self.accountants];
}
//
//- (NSArray *)freeWashers {
//    @synchronized (self) {
//        return [self.washers filteredArrayWithBlock:^BOOL(IDPWorker *washer) {
//            return washer.state == IDPWorkerReadyForWork;
//        }];
//    }
//}

@end
