//
//  UITextField+SwiftAppearance.m
//  ViperWeather
//
//  Created by Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

#import "UITextField+SwiftAppearance.h"

@implementation UITextField (SwiftAppearance)

+ (instancetype)appearanceWhenContainedWithin:(Class<UIAppearanceContainer>)containerClass {
    if ([self conformsToProtocol:@protocol(UIAppearance)]) {
        return [self appearanceWhenContainedIn:containerClass, nil];
    }
    return nil;
}

@end
