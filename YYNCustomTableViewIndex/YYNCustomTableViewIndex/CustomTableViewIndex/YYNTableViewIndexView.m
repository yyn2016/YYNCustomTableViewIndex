//
//  YYNTableViewIndexView.m
//  YYNCustomTableViewIndexView
//
//  Created by czf1 on 17/3/15.
//  Copyright © 2017年 杨亚楠. All rights reserved.
//

#import "YYNTableViewIndexView.h"


//屏幕的宽 高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface YYNTableViewIndexView(){
    CGFloat itemViewHeight;
    NSInteger highlightedItemIndex;
}

@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)NSMutableArray *itemViewLists;

@end

@implementation YYNTableViewIndexView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _bottomView = [[UIView alloc] initWithFrame:self.frame];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.clipsToBounds = YES;
        _bottomView.layer.cornerRadius = 12.f;
        [self addSubview:self.bottomView];
        [self.bottomView setHidden:NO];
        
        _itemViewLists = [[NSMutableArray alloc] init];
        _itemHeight = 0.f;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self createItemViews];
}

- (void)createItemViews{
    if (self.itemViewLists.count == 0) {
        itemViewHeight = CGRectGetHeight(self.bounds)/(CGFloat)self.itemViewLists.count;//平分item的高度
    }
    
    if (self.itemHeight > 0) {
        itemViewHeight = self.itemHeight;
    }
    
    CGFloat itemViewY = 0.0;
    for (UIView *itemView in self.itemViewLists) {
        itemView.frame = CGRectMake(0, itemViewY, CGRectGetWidth(self.bounds), _itemHeight);
        itemViewY += _itemHeight;
       // [itemView layoutSubviews];
    }
}

- (void)reloadItemViews{
    for (UIView *itemView in self.itemViewLists) {
        [itemView removeFromSuperview];
    }
    [self.itemViewLists removeAllObjects];
    
    //item的个数
    NSInteger numberOfItems = 0;
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfItemViewForSectionIndexView:)]) {
        numberOfItems = [_dataSource numberOfItemViewForSectionIndexView:self];
    }
    
    for (int i = 0; i < numberOfItems; i++) {
        if ([self.dataSource respondsToSelector:@selector(numberOfItemViewForSectionIndexView:)]) {
            
            YYNTableViewIndexItemView *itemView = [_dataSource sectionIndexView:self itemViewForSection:i];
            itemView.section = i;
            
            
            [self.itemViewLists addObject:itemView];
            [self addSubview:itemView];
        }
    }
    
    [self createItemViews];
}

- (void)selectItemViewForSection:(NSInteger)section{
    NSLog(@"*******************section = %ld**********************",section);
    
    //调用协议方法
    if (_dataSource && [_dataSource respondsToSelector:@selector(sectionIndexView:didSelectSection:)]) {
        [self.delegate sectionIndexView:self didSelectSection:section];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _bottomView.hidden = NO;
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    for (YYNTableViewIndexItemView *itemView in self.itemViewLists) {
        //判断选中的是哪个索引
        if (CGRectContainsPoint(itemView.frame, touchPoint)) {
            [self selectItemViewForSection:itemView.section];
            highlightedItemIndex  = itemView.section;
            return;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _bottomView.hidden = NO;
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (YYNTableViewIndexItemView *itemView in self.itemViewLists) {
        if (CGRectContainsPoint(itemView.frame, touchPoint)) {
            if (itemView.section != highlightedItemIndex) {
                [self selectItemViewForSection:itemView.section];
                highlightedItemIndex  = itemView.section;
                return;
                
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesCancelled:touches withEvent:event];
}


@end

















