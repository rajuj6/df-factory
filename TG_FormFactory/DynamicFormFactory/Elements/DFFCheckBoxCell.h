//
//  DFFCheckBoxCell.h
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFFObject.h"


/**
 * DFFCheckBoxCell:
 * custom cell setup for select multiple options form list element
 */

@interface DFFCheckBoxCell : UITableViewCell

@property (nonatomic, strong) UIViewController *showInViewController; // UIViewCOntroller for push selection option view

/**
 * errorValidation:
 * NSString error message cell data validation
 */

@property (nonatomic, strong)  NSString *errorValidation;

/**
 * selectedOptionValues:
 * selectedOptionValues of checked list access from main class of tableview
 */

@property (nonatomic, strong) NSMutableArray *selectedOptionValues;

/**
 * setupCellWithData:
 * It is a method for setup cell data. First argument is object type of FieldObject model that conatain all element's data. Second argument is index path of curent cell
 */

-(void) setupCellWithData:(DFFObject *)field cellIndexPath:(NSIndexPath *)cellIndexPath;

/**
 * showOptionView:
 * It is a method for call from main tableview form when didSelectRowAtIndexPath call.
 */

-(void) showOptionView;

@end


