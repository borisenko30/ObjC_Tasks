//
//  IDPWorkerDelegate.h
//  Task06_ObjC
//
//  Created by Student003 on 5/18/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPWorkerDelegate <NSObject>

- (void)delegatingObjectDidFinishWork:(id)object;

@end
