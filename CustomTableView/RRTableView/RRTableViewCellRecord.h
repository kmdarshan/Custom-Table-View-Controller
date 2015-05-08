//
//  RRTableViewCellRecord.h
//  CustomTableView
//
//  Created by Darshan Katrumane on 5/6/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRTableViewCell.h"
@interface RRTableViewCellRecord : NSObject
@property (nonatomic) CGFloat startPositionY;
@property (nonatomic) CGFloat height;
@property (nonatomic, strong) RRTableViewCell* cachedCell;
@end
