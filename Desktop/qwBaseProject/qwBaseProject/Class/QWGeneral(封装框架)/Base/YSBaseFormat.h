//
//  YSBaseFormat.h
//  MoneyIsGreat
//
//  Created by cli on 2019/3/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YSBaseFormatDelegate <NSObject>

@optional
-(void)lmBaseFormatSuccess:(id)success;
-(void)lmBaseFormatFail:(id)fail;


@end

@interface YSBaseFormat : NSObject

@property(nonatomic , weak)id<YSBaseFormatDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
