//
//  MBProgressHUD+Padding.h
//  NT-Dunstans_iOS
//
//  Created by 胡焘坤 on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Padding)
@property (nonatomic, strong) NSArray *paddingConstraints;
- (void)updatePaddingConstraints;
@end
