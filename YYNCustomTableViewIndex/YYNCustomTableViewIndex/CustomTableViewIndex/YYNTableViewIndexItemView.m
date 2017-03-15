//
//  YYNTableViewIndexItemView.m
//  YYNCustomTableViewIndexView
//
//  Created by czf1 on 17/3/15.
//  Copyright © 2017年 杨亚楠. All rights reserved.
//

#import "YYNTableViewIndexItemView.h"

@interface YYNTableViewIndexItemView()

@property (nonatomic, retain) UIView *contentView;

@end

@implementation YYNTableViewIndexItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.highlightedTextColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentView.frame = self.bounds;
    _titleLabel.frame = self.contentView.bounds;
    NSLog(@"%lf",self.bounds.size.width);
}






@end
