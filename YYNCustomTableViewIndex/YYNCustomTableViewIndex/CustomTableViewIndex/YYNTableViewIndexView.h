//
//  YYNTableViewIndexView.h
//  YYNCustomTableViewIndexView
//
//  Created by czf1 on 17/3/15.
//  Copyright © 2017年 杨亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYNTableViewIndexItemView.h"

@class YYNTableViewIndexView;

@protocol YYNTableViewIndexViewDataSource <NSObject>

- (YYNTableViewIndexItemView *)sectionIndexView:(YYNTableViewIndexView *)sectionIndexView itemViewForSection:(NSInteger)section;

- (NSInteger)numberOfItemViewForSectionIndexView:(YYNTableViewIndexView *)sectionIndexView;

@optional
- (UIView *)sectionIndexView:(YYNTableViewIndexView *)sectionIndexView
       calloutViewForSection:(NSInteger)section;
- (NSString *)sectionIndexView:(YYNTableViewIndexView *)sectionIndexView
               titleForSection:(NSInteger)section;

@end


@protocol YYNSectionIndexViewDelegate <NSObject>

- (void)sectionIndexView:(YYNTableViewIndexView *)sectionIndexView
        didSelectSection:(NSInteger)section;

@end

@interface YYNTableViewIndexView : UIView

@property (nonatomic, weak) id<YYNTableViewIndexViewDataSource>dataSource;
@property (nonatomic, weak) id<YYNSectionIndexViewDelegate>delegate;


//itemView的高度，默认是根据itemView的数目平均分YYNTableViewIndexItemView的对象的高度
@property (nonatomic, assign) CGFloat itemHeight;


- (void)reloadItemViews;



@end
