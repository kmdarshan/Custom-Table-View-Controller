//
//  RRHelper.m
//  CustomTableView
//
//  Created by darshan on 5/7/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import "RRHelper.h"

@implementation RRHelper
+(NSString*)removeChars:(NSString*)filterChar inWord:(NSString*)word {
    NSLog(@"%@ %@",[word stringByReplacingOccurrencesOfString:filterChar withString:@""], word);
    return [word stringByReplacingOccurrencesOfString:filterChar withString:@""];
}
@end
