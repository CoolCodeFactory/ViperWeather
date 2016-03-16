//
//  UITextField+SwiftAppearance.h
//  ViperWeather
//
//  Created by Dmitri Utmanov on 03/03/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SwiftAppearance)

+ (instancetype)appearanceWhenContainedWithin:(Class<UIAppearanceContainer>)containerClass;

@end
