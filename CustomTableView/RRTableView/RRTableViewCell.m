//
//  RRTableViewCell.m
//  CustomTableView
//
//  Created by Darshan Katrumane on 5/6/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import "RRTableViewCell.h"

@implementation RRTableViewCell
- (id) initWithIdentifier: (NSString*) identifier
{
    self = [super initWithFrame: CGRectZero];
    if (self)
    {
        [self setIdentifier:identifier];
        [self setup];
    }
    return self;
}
- (id) initWithIdentifier: (NSString*) identifier andFrame:(CGRect)frame;
{
    self = [super initWithFrame: frame];
    if (self)
    {
        [self setIdentifier:identifier];
        [self setup];
    }
    return self;
}
-(void) setup {
    [[self layer] setBorderWidth:1.0f];
    [[self layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0, self.frame.size.width-10.0f, self.frame.size.height/2.0)];
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [self addSubview:self.titleLabel];
    self.detailedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y, self.frame.size.width-10.0f, self.frame.size.height/2.0)];
    [self addSubview:self.detailedLabel];
    [self.detailedLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
}
-(void)setDetailedLabelText:(NSString *)detailedLabelText {
    [self.detailedLabel setText:detailedLabelText];
}
-(void)setTitleLabelText:(NSString *)titleLabelText {
    [self.titleLabel setText:titleLabelText];
}
@end
