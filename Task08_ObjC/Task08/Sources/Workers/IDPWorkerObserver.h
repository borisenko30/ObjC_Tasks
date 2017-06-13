//
//  IDPWorkerObserver.h
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/30/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPWorkerObserver <NSObject>

@optional
- (void)workerDidBecomeReadyForWork:(id)worker;
- (void)workerDidBecomeBusy:(id)worker;
- (void)workerDidBecomeReadyForProcessing:(id)worker;

@end
