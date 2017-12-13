//
//  DFFButtonCell.h
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DFFObject.h"

@protocol DFFButtonCellDelegate;

/**
 * DFFButtonCell:
 * custom cell setup for button element
 */

@interface DFFButtonCell : UITableViewCell

@property (assign, nonatomic) id <DFFButtonCellDelegate> delegate; // Delegate of <ButtonCellDelegate> protocol

/**
 * setupCellWithData:
 * It is a method for setup cell data. First argument is object type of FieldObject model that conatain all element's data. Second argument is index path of curent cell
 */

-(void) setupCellWithData:(DFFObject *)field cellIndexPath:(NSIndexPath *)cellIndexPath;

@end


/**
 * ButtonCellDelegate:
 * protocol for call button press event method of current cell.
 */
@protocol DFFButtonCellDelegate <NSObject>

@optional
-(void) didPressButtonAtIndex:(DFFButtonCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
