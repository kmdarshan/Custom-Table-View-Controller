//
//  RRComplaint.m
//  CustomTableView
//
//  Created by darshan on 5/7/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import "RRComplaint.h"
#import "RRHelper.h"
@implementation RRComplaint
-(NSMutableArray *)parseFile:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]){
        NSError *error;
        NSString *fileString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (!fileString) {
            NSLog(@"Error reading file.");
            return nil;
        }
        __block NSMutableArray *complaints = [NSMutableArray new];
        NSArray *lines = [fileString componentsSeparatedByString:@"\n"];
        for (id line in lines) {
            NSArray *words = [line componentsSeparatedByString:@","];
            RRComplaint *obj = [RRComplaint new];
            if ([words count] > 1) {
                [obj setName:[RRHelper removeChars:@"\"" inWord:[words objectAtIndex:1]]];
            }
            if ([words count] > 2) {
                [obj setType:[RRHelper removeChars:@"\"" inWord:[words objectAtIndex:3]]];
            }
            [complaints addObject:obj];
        }
        if ([complaints count] > 0) {
            [complaints removeObjectAtIndex:0]; // assuming first line is column names
        }
        return complaints;
    }
    return nil;
}
@end
