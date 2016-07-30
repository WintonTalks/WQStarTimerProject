//
//  QCPLimitedTimerView.h
//  QueryViolations
//
//  Created by 孙文强 on 16/7/18.
//  Copyright © 2016年 eclicks. All rights reserved.
//  限时抢购定时器

#import <UIKit/UIKit.h>
@class QCPLimitedTimerView;

typedef enum {
    TimerViewTypeUnit, //时分秒
    TimerViewTypeColon //冒号
}QCPLimitedTimerViewType;

@protocol QCPLimitedTimerViewDelegate <NSObject>
- (void)stopLimitedTimerClick:(QCPLimitedTimerView *)timerView;
@end

@interface QCPLimitedTimerView : UIView
@property (nonatomic) QCPLimitedTimerViewType type;
@property (nonatomic, weak) id<QCPLimitedTimerViewDelegate>delegate;
- (void)starLimitedTimer:(NSDate *)endTime;
- (void)stopTimer;
@end
