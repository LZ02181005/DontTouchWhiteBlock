//
//  FirstVCModel.h
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface FirstBannerModel : NSObject

///轮播图图片
@property (nonatomic ,copy) NSString *linkUrl;
///轮播图图片
@property (nonatomic ,copy) NSString *picUrl;

@end


@interface FirstAuthModel : NSObject

///需要认证的总数
@property (nonatomic ,copy) NSString *total;
///
@property (nonatomic ,copy) NSString *result;
///
@property (nonatomic ,copy) NSString *qualified;

@end

@interface FirstVCModel : NSObject

///认证信息
@property (nonatomic ,copy) FirstAuthModel *auth;
///银行卡账号
@property (nonatomic ,copy) NSString *cardNo;
///申请额度arr
@property (nonatomic ,strong) NSArray *creditList;
///申请天数arr
@property (nonatomic ,strong) NSArray *dayList;
///banner图数组
@property (nonatomic ,strong) NSArray <FirstBannerModel *> *indexBanner;
///综合汇率
@property (nonatomic ,copy) NSString *interest;
///是否借款
@property (nonatomic ,copy) NSString *isBorrow;
///是否完成第一次借款
@property (nonatomic ,copy) NSString *isHasFirstCredit;
///是否设置了交易密码
@property (nonatomic ,copy) NSString *isPwd;
///是否是vip
@property (nonatomic ,copy) NSString *isVip;
///最大申请金额
@property (nonatomic ,copy) NSString *maxCredit;
///最小申请金额
@property (nonatomic ,copy) NSString *minCredit;
///最大借款天数
@property (nonatomic ,copy) NSString *maxDays;
///最小借款天数
@property (nonatomic ,copy) NSString *minDays;
///成功借款数
@property (nonatomic ,copy) NSString *successBorrowCount;
///可借款总额
@property (nonatomic ,copy) NSString *total;

@end

NS_ASSUME_NONNULL_END
