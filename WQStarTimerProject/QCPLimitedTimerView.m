//
//  QCPLimitedTimerView.m
//  QueryViolations
//
//  Created by 孙文强 on 16/7/18.
//  Copyright © 2016年 eclicks. All rights reserved.
//
#import "BPUIViewAdditions.h"
#import "QCPLimitedTimerView.h"

@interface QCPLimitedTimerView()
{
    UILabel *_dayNumberLabel;
    UILabel *_hourNumberLabel;
    UILabel *_minuteNumberLabel;
    UILabel *_secondNumberLabel;
    UILabel *_dayUnitLabel, *_houLabel, *_minuteUnitLabel, *_secondUnitLabel;
    NSDate *_endTime;
    NSTimer *_timer;
}
@end

#define FONT(size)  [UIFont systemFontOfSize:size]
@implementation QCPLimitedTimerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _endTime = nil;
        _dayNumberLabel = [[UILabel alloc] init];
        _dayNumberLabel.backgroundColor = [UIColor whiteColor];
        _dayNumberLabel.font = FONT(11);
        _dayNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dayNumberLabel];
        
        _dayUnitLabel = [[UILabel alloc] init];
        _dayUnitLabel.backgroundColor = [UIColor clearColor];
        _dayUnitLabel.textColor = [UIColor blackColor];
        _dayUnitLabel.text = @"天";
        _dayUnitLabel.textAlignment = NSTextAlignmentCenter;
        _dayUnitLabel.font = FONT(11);
        [self addSubview:_dayUnitLabel];
        
        _hourNumberLabel = [[UILabel alloc] init];
        _hourNumberLabel.backgroundColor = [UIColor whiteColor];
        _hourNumberLabel.textAlignment = NSTextAlignmentCenter;
        _hourNumberLabel.font = FONT(11);
        [self addSubview:_hourNumberLabel];
        
        //时
        _houLabel = [[UILabel alloc] init];
        _houLabel.backgroundColor = [UIColor clearColor];
        _houLabel.textAlignment = NSTextAlignmentCenter;
        _houLabel.textColor = [UIColor blackColor];
        _houLabel.font = FONT(11);
        [self addSubview:_houLabel];
        
        _minuteNumberLabel = [[UILabel alloc] init];
        _minuteNumberLabel.backgroundColor = [UIColor whiteColor];
        _minuteNumberLabel.textAlignment = NSTextAlignmentCenter;
        _minuteNumberLabel.font = FONT(11);
        [self addSubview:_minuteNumberLabel];
        
        //分
        _minuteUnitLabel = [[UILabel alloc] init];
        _minuteUnitLabel.backgroundColor = [UIColor clearColor];
        _minuteUnitLabel.textColor = [UIColor blackColor];
        _minuteUnitLabel.textAlignment = NSTextAlignmentCenter;
        _minuteUnitLabel.font = FONT(11);
        [self addSubview:_minuteUnitLabel];
        
        _secondNumberLabel = [[UILabel alloc] init];
        _secondNumberLabel.backgroundColor = [UIColor whiteColor];
        _secondNumberLabel.textAlignment = NSTextAlignmentCenter;
        _secondNumberLabel.font = FONT(11);
        [self addSubview:_secondNumberLabel];
        
        //秒
        _secondUnitLabel = [[UILabel alloc] init];
        _secondUnitLabel.backgroundColor = [UIColor clearColor];
        _secondUnitLabel.textColor = [UIColor blackColor];
        _secondUnitLabel.textAlignment = NSTextAlignmentCenter;
        _secondUnitLabel.font = FONT(11);
        [self addSubview:_secondUnitLabel];
    }
    return self;
}

- (void)starLimitedTimer:(NSDate *)endTime
{
    _endTime = endTime;
    [self clearTimer];
    [self updateTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)runTimer
{
    [self updateTimer];
}

- (void)updateTimer
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponets = [calendar components:unitFlags fromDate:today toDate:_endTime options:0];
    _dayNumberLabel.text = [NSString stringWithFormat:@"%zd",[dateComponets day]];
    _hourNumberLabel.text = [NSString stringWithFormat:@"%zd",[dateComponets hour]];
    _minuteNumberLabel.text = [NSString stringWithFormat:@"%zd",[dateComponets minute]];
    _secondNumberLabel.text = [NSString stringWithFormat:@"%zd",[dateComponets second]];
    if ([dateComponets day] == 0 && [dateComponets hour] == 0 && [dateComponets minute] == 0 && [dateComponets second] == 0) {
        [self clearTimer];
        if (_delegate && [_delegate respondsToSelector:@selector(stopLimitedTimerClick:)]) {
            [_delegate stopLimitedTimerClick:self];
        }
    }
}

- (void)stopTimer
{
    _dayNumberLabel.text = @"0";
    _hourNumberLabel.text = @"0";
    _minuteNumberLabel.text = @"0";
    _secondNumberLabel.text = @"0";
    [self clearTimer];
}

- (void)setType:(QCPLimitedTimerViewType)type
{
    _type = type;
    if (type == TimerViewTypeUnit) {
        _houLabel.text = @"时";
        _minuteUnitLabel.text = @"分";
        _secondUnitLabel.text = @"秒";
    } else {
        _houLabel.text = @":";
        _minuteUnitLabel.text = @":";
        _secondUnitLabel.hidden = YES;
    }
    self.width += 8;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _dayNumberLabel.frame = CGRectMake(5, 5, 20, self.height-10);
    CGFloat dayNumberTop = _dayNumberLabel.top;
    _dayUnitLabel.frame = CGRectMake(_dayNumberLabel.right+5, dayNumberTop, 20, _dayNumberLabel.height);
    _hourNumberLabel.frame = CGRectMake(_dayUnitLabel.right+5, dayNumberTop, 20, _dayNumberLabel.height);
    _houLabel.frame = CGRectMake(_hourNumberLabel.right+5, dayNumberTop, 20, _dayNumberLabel.height);
    _minuteNumberLabel.frame = CGRectMake(_houLabel.right+5, dayNumberTop, 20, _dayNumberLabel.height);
    _minuteUnitLabel.frame = CGRectMake(_minuteNumberLabel.right+5, dayNumberTop, 20, _dayNumberLabel.height);
    _secondNumberLabel.frame = CGRectMake(_minuteUnitLabel.right+5, dayNumberTop, 20, _dayNumberLabel.height);
    _secondUnitLabel.frame = CGRectMake(_secondNumberLabel.right+5, dayNumberTop, 20, _dayNumberLabel.height);
}

- (void)clearTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
