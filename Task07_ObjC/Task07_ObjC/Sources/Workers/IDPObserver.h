//
//  IDPObserver.h
//  Task07_ObjC
//
//  Created by Student003 on 5/22/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPObserver <NSObject>

@optional
- (void)objectIsReadyForProcessing:(id)object;
- (void)objectIsReadyForWork:(id)object;

@end
