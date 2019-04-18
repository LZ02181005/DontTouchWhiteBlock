//
//  RelationPickerView.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RelationPickerView : UIView

///数据的Array
@property (nonatomic ,strong) NSArray *objectArray;
///展示方法
+ (void)showWithMessageArray:(NSArray *)messageArray RelationCallBack:(void(^)(NSString *topic))callBack;

@end

NS_ASSUME_NONNULL_END
