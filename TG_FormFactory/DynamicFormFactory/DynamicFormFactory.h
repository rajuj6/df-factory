//
//  DynamicFormFactory.h
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Protocol declaration <DynamicFormFactoryDelegate>
 *  Protocol contain methods related to DynamicForm. There are one methods in this
 */
@protocol DynamicFormFactoryDelegate <NSObject>

@optional

/**
 * First Method:
 * submittedData: Method for when submit button pressed and check form valition rule. If no any error according to rule then submittedData will fire for print. It is take argument of formatted form data name-value format.
 */
-(void) submittedData:(NSString *)jsonFormStringData;

@end

@interface DynamicFormFactory : UITableView <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>{
    /**
     * Local variables declaration
     */
    
    UIGestureRecognizer *tapper; // Tap anywhere to tableview handle endEditing: method
    NSMutableArray *arrFields; // Form fields list in mutable array
}

/**
 *  Delegate of <DynamicFormFactoryDelegate> protocol for data send submittedData
 */
@property (nonatomic, strong) id <DynamicFormFactoryDelegate> fdelegate;

/**
 *  showDynamicForm is main funtion class
 *  it returns void.
 *  It is take first argument as JSON linear NSString
 *  Second argument to id view controller where form will be show
 *  Last one is delegate of <DynamicFormFactoryDelegate> type protocol to callback form methods
 */

-(void) showDynamicForm:(NSString *)jsonStr showInView:(UIViewController *)showInView withDelegate:(id<DynamicFormFactoryDelegate>)withDelegate;

@end
