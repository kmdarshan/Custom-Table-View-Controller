//
//  RRTableView.m
//  CustomTableView
//
//  Created by Darshan Katrumane on 5/6/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import "RRTableView.h"

@interface RRTableView ()
@property (nonatomic, strong) NSMutableSet *cache;
@property (nonatomic, retain) NSMutableArray *perCellRecords;
@property (nonatomic, strong) NSMutableIndexSet *visibleRows;
@end

@implementation RRTableView
- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup;
{
    [self setRowHeight: defaultRowHeight];
    [self setRowMargin: defaultRowMargin];
    self.visibleRows = [NSMutableIndexSet new];
    self.cache = [NSMutableSet new];
}

- (RRTableViewCell*) dequeueReusableCellWithIdentifier: (NSString*) identifier {
    if (![self enableCaching]) {
        [self setCache:nil];
        return nil;
    }
    
    RRTableViewCell* poolCell = nil;
    for (RRTableViewCell* cell in self.cache) {
        if ([[cell identifier] isEqualToString: identifier]) {
            poolCell = cell;
            break;
        }
    }
    
    if (poolCell) {
        [self.cache removeObject: poolCell];
    }
    return poolCell;
}

- (void) reloadData
{
    [self returnNonVisibleRowsToThePool: nil];
    [self generateHeightAndOffsetData];
    [self layoutTableRows];
}

- (void) generateHeightAndOffsetData
{
    CGFloat currentOffsetY = 0.0;
    BOOL checkHeightForEachRow = [[self delegate] respondsToSelector: @selector(tableView:heightForRow:)];
    NSMutableArray* newRowRecords = [NSMutableArray array];
    NSInteger numberOfRows = 0;
    if ([[self dataSource] respondsToSelector:@selector(numberOfRows:)]) {
        numberOfRows = [[self dataSource] numberOfRows: self];
    }
    for (NSInteger row = 0; row < numberOfRows; row++)
    {
        RRTableViewCellRecord* record = [RRTableViewCellRecord new];
        CGFloat rowHeight = checkHeightForEachRow ? [[self delegate] tableView:self heightForRow:row] : [self rowHeight];
        [record setHeight: rowHeight + self.rowMargin];
        [record setStartPositionY: currentOffsetY + self.rowMargin];
        [newRowRecords insertObject: record atIndex: row];
        currentOffsetY = currentOffsetY + rowHeight + self.rowMargin;
    }
    [self setPerCellRecords:newRowRecords];
    [self setContentSize: CGSizeMake([self bounds].size.width,  currentOffsetY)];
}

- (void) returnNonVisibleRowsToThePool: (NSMutableIndexSet*) currentVisibleRows
{
    [[self visibleRows] removeIndexes: currentVisibleRows];
    [[self visibleRows] enumerateIndexesUsingBlock:^(NSUInteger row, BOOL *stop) {
         RRTableViewCell* tableViewCell = [(RRTableViewCellRecord*)[[self perCellRecords] objectAtIndex: row] cachedCell];
         if (tableViewCell) {
             [[self cache] addObject: tableViewCell];
             [tableViewCell removeFromSuperview];
             [self setCachedCell:nil forRow:row];
         }
     }];
    [self setVisibleRows: currentVisibleRows];
}

- (void) setCachedCell: (RRTableViewCell*) cell forRow: (NSInteger) row {
    [(RRTableViewCellRecord*)[[self perCellRecords] objectAtIndex: row] setCachedCell: cell];
}

#pragma mark - scrollView
- (void) setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset: contentOffset];
    [self layoutTableRows];
}


#pragma mark - layout the table rows
- (NSInteger) findRowForOffsetY: (CGFloat) yPosition inRange: (NSRange) range
{
    if ([[self perCellRecords] count] == 0) return 0;
    
    RRTableViewCellRecord* rowRecord = [RRTableViewCellRecord new];
    [rowRecord setStartPositionY: yPosition];
    
    NSInteger returnValue = [[self perCellRecords] indexOfObject: rowRecord
                                               inSortedRange: NSMakeRange(0, [[self perCellRecords] count])
                                                     options: NSBinarySearchingInsertionIndex
                                             usingComparator: ^NSComparisonResult(RRTableViewCellRecord* rowRecord1, RRTableViewCellRecord* rowRecord2){
                                                 if ([rowRecord1 startPositionY] < [rowRecord2 startPositionY]) return NSOrderedAscending;
                                                 return NSOrderedDescending;
                                             }];
    if (returnValue == 0) return 0;
    return returnValue-1;
}

- (void) layoutTableRows {
    CGFloat currentStartY = [self contentOffset].y;
    CGFloat currentEndY = currentStartY + [self frame].size.height;
    NSInteger rowToDisplay = [self findRowForOffsetY: currentStartY inRange: NSMakeRange(0, [[self perCellRecords] count])];
    
    NSMutableIndexSet* newVisibleRows = [NSMutableIndexSet new];
    CGFloat yOrigin;
    CGFloat rowHeight;
    do
    {
        [newVisibleRows addIndex: rowToDisplay];
        yOrigin = [(RRTableViewCellRecord*)[[self perCellRecords] objectAtIndex: rowToDisplay] startPositionY];;
        rowHeight = [(RRTableViewCellRecord*)[[self perCellRecords] objectAtIndex: rowToDisplay] height];
        RRTableViewCell* cell = [(RRTableViewCellRecord*)[[self perCellRecords] objectAtIndex: rowToDisplay] cachedCell];
        
        if (!cell)
        {
            cell = [[self dataSource] tableView:self cellForRowAtIndex:rowToDisplay];
            [self setCachedCell: cell forRow: rowToDisplay];
            
            [cell setFrame: CGRectMake(0.0, yOrigin, [self bounds].size.width, rowHeight - self.rowMargin)];
            [self addSubview: cell];
        }
        
        rowToDisplay++;
    }
    while (yOrigin + rowHeight < currentEndY && rowToDisplay < [[self perCellRecords] count]);
    [self returnNonVisibleRowsToThePool: newVisibleRows];
}

@end
