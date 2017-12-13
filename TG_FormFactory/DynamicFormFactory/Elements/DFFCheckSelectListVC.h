//
//  DFFCheckSelectListVC.h
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * DFFSelectOptionDelegate:
 * Shared protocol for delegate to send data of selected option in NSMutableArray
 */


@protocol DFFSelectOptionDelegate <NSObject>
-(void)setSelectedOption:(NSMutableArray *)selectedArr;
@end


/**
 * DFFCheckSelectListVC:
 * Showing UITableViewDelegate and UITableViewDataSource option list in UITableView
 */

@interface DFFCheckSelectListVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) id <DFFSelectOptionDelegate> ldelegate; // delegate for protocol <DFFSelectOptionDelegate> that contains selectedOption method.

@property (nonatomic, strong) NSArray *optionValues; // Values that will show in list array

@property (nonatomic, strong) NSMutableArray *selectedOptionValues; // Values that has been selected in tableview

@end
