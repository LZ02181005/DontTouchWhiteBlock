//
//  UIImageView+YS.m
//  KYGF
//
//  Created by Magic-Yu on 2017/9/14.
//  Copyright © 2017年 beyondin. All rights reserved.
//

#import "UIImageView+YS.h"




@implementation UIImageView (YS)

- (void)setImageUrl:(NSString *)imageUrl{
    
    [self sd_setImageWithURL:kUrl(imageUrl)];
    
}

- (NSString *)imageUrl{
    return nil;
}


- (void)setNormalImageUrl:(NSString *)normalImageUrl{
    [self sd_setImageWithURL:kUrl(normalImageUrl) placeholderImage:Img(@"logo")];
}

- (NSString *)normalImageUrl{
    return nil;
}

- (void)setHeadImageUrl:(NSString *)headImageUrl{
    [self sd_setImageWithURL:kUrl(headImageUrl) placeholderImage:Img(@"head")];
}

- (NSString *)headImageUrl{
    return nil;
}



@end
