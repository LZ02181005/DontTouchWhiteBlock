//
//  QWAlertView.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QWAlertViewType) {
    QWAlertViewTypeAlert,
    QWAlertViewTypeWarning
};

@interface QWAlertView : UIView

@end

NS_ASSUME_NONNULL_END
