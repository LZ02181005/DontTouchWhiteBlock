//
//  MBProgressHUD+Padding.m
//  NT-Dunstans_iOS
//
//  Created by 胡焘坤 on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MBProgressHUD+Padding.h"

static const CGFloat MBDefaultPadding = 20.f;
@implementation MBProgressHUD (Padding)
@dynamic paddingConstraints;

- (void)updatePaddingConstraints {
    // Set padding dynamically, depending on whether the view is visible or not
    __block BOOL hasVisibleAncestors = NO;
    [self.paddingConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *padding, NSUInteger idx, BOOL *stop) {
        UIView *firstView = (UIView *)padding.firstItem;
        UIView *secondView = (UIView *)padding.secondItem;
        BOOL firstVisible = !firstView.hidden && !CGSizeEqualToSize(firstView.intrinsicContentSize, CGSizeZero);
        BOOL secondVisible = !secondView.hidden && !CGSizeEqualToSize(secondView.intrinsicContentSize, CGSizeZero);
        // Set if both views are visible or if there's a visible view on top that doesn't have padding
        // added relative to the current view yet
        padding.constant = (firstVisible && (secondVisible || hasVisibleAncestors)) ? MBDefaultPadding : 0.f;
        hasVisibleAncestors |= secondVisible;
    }];
}
@end
