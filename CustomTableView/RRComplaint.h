//
//  RRComplaint.h
//  CustomTableView
//
//  Created by darshan on 5/7/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRComplaint : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
-(NSMutableArray*) parseFile:(NSString*)filePath;
@end
