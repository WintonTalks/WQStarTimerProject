//
//  MyTableViewCell.m
//  WQStarTimerProject
//
//  Created by 孙文强 on 16/7/27.
//  Copyright © 2016年 Happy Day. All rights reserved.
//

#import "MyTableViewCell.h"
#import "QCPLimitedTimerView.h"

@interface MyTableViewCell()<QCPLimitedTimerViewDelegate>
{
    QCPLimitedTimerView *_timerView;
}
@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _timerView = [[QCPLimitedTimerView alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
        _timerView.delegate = self;
        _timerView.type = TimerViewTypeColon;
        [self.contentView addSubview:_timerView];
        
    }
    return self;
}

- (void)setEndDate:(NSString *)endDate
{
    _endDate = endDate;
    [_timerView starLimitedTimer:[NSDate dateWithTimeIntervalSince1970:[endDate integerValue]]];
}

#pragma mark QCPLimitedTimerViewDelegate
- (void)stopLimitedTimerClick:(QCPLimitedTimerView *)timerView
{


}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
