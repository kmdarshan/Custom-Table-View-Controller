//
//  RRTableViewCell.h
//  CustomTableView
//
//  Created by Darshan Katrumane on 5/6/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRTableViewCell : UIView
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailedLabel;
@property (nonatomic, strong) NSString *titleLabelText;
@property (nonatomic, strong) NSString *detailedLabelText;
- (id) initWithIdentifier: (NSString*) identifier;
- (id) initWithIdentifier: (NSString*) identifier andFrame:(CGRect)frame;
@end
