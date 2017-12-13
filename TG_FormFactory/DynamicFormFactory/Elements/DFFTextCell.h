//
//  DFFTextCell.h
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFFObject.h"

/**
 * DFFTextCell:
 * custom cell setup for text input element
 */


@interface DFFTextCell : UITableViewCell<UITextFieldDelegate>

/**
 * errorValidation:
 * NSString error message cell data validation
 */

@property (nonatomic, strong)  NSString *errorValidation;

/**
 * setupCellWithData:
 * It is a method for setup cell data. First argument is object type of FieldObject model that conatain all element's data. Second argument is index path of curent cell
 */

-(void) setupCellWithData:(DFFObject *)field cellIndexPath:(NSIndexPath *)cellIndexPath;

@end

