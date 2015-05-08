//
//  RRTableView.h
//  CustomTableView
//
//  Created by Darshan Katrumane on 5/6/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRTableViewCell.h"
#import "RRTableViewCellRecord.h"
static CGFloat defaultRowHeight = 44.0f;
static CGFloat defaultRowMargin = 2.0f;
@protocol RRTableViewDatasource;
@protocol RRTableViewDelegate;

@interface RRTableView : UIScrollView
@property (nonatomic) CGFloat rowHeight;
@property (nonatomic) CGFloat rowMargin;
@property (nonatomic) BOOL enableCaching;
// @property (nonatomic) CGFloat contentInset; we can use this to set the content inset
@property (nonatomic,weak) id<RRTableViewDelegate> delegate;
@property (nonatomic,weak) id<RRTableViewDatasource> dataSource;
- (RRTableViewCell*) dequeueReusableCellWithIdentifier: (NSString*) identifier;
- (void) reloadData;
@end

@protocol RRTableViewDelegate<NSObject, UIScrollViewDelegate>
@optional
- (CGFloat)tableView:(RRTableView*)tableView heightForRow: (NSInteger) row;
@end

@protocol RRTableViewDatasource <NSObject>
@required
-(NSInteger) numberOfRows:(RRTableView*)tableView;
-(RRTableViewCell*) tableView:(RRTableView*)tableView cellForRowAtIndex:(NSInteger)row;
@end
