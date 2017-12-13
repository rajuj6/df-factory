//
//  DynamicFormFactory.m
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import "DynamicFormFactory.h"

#import "DFFTextCell.h"
#import "DFFCheckBoxCell.h"
#import "DFFCheckSelectListVC.h"
#import "DFFButtonCell.h"
#import "DFFObject.h"

@interface DynamicFormFactory ()<DFFButtonCellDelegate>
@property (nonatomic, strong) UIViewController *showInViewController;
@end

@implementation DynamicFormFactory

/**
 * Call to this function kickstarts DynamicFormFactory. This should be called as early as possible in application life cycle.
 * Currently, it gets called in  UIController viewDidLoad: method
 
 */

-(void) showDynamicForm:(NSString *)jsonStr showInView:(UIViewController *)showInView withDelegate:(id<DynamicFormFactoryDelegate>)withDelegate{
    
    self.fdelegate = withDelegate; // set delegate for form methods
    self.showInViewController = showInView; // set viewcontroller for push method
    
    self.backgroundColor = [UIColor colorWithRed: 0.929 green: 0.922 blue: 0.91 alpha: 1];
    self.delegate = self;
    self.dataSource = self;
    //Register UITableViewCell classes
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell1"];
    [self registerClass:[DFFTextCell class] forCellReuseIdentifier:@"Cell2"];
    [self registerClass:[DFFButtonCell class] forCellReuseIdentifier:@"Cell3"];
    [self registerClass:[DFFCheckBoxCell class] forCellReuseIdentifier:@"Cell4"];
    
    // For remove UITableView blank cell separator
    [self setTableFooterView:[UIView new]];
    
    // GestureReconizer to endEditing:
    tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnyWhere:)];
    tapper.cancelsTouchesInView = NO;
    tapper.delegate = self;
    [self addGestureRecognizer:tapper];
    
    arrFields = [[NSMutableArray alloc] init]; // array initialize
    
    
    // JSON string parse to NSArray
    NSError *error;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arrListField = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if(arrListField.count > 0){
        for (NSDictionary *field in arrListField) {
            DFFObject *fieldObj = [[DFFObject alloc] init];
            [fieldObj setData:field];
            [arrFields addObject:fieldObj];
        }
    }
    
    [showInView.view addSubview:self]; // add UITableView form to view
    
    
    // Constraint for UITableView
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *width =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:0 toItem:showInView.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    NSLayoutConstraint *height =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:0 toItem:showInView.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:showInView.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:showInView.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.f];
    
    [showInView.view addConstraint:width];
    [showInView.view addConstraint:height];
    [showInView.view addConstraint:top];
    [showInView.view addConstraint:leading];
    
    
}

- (void)tapAnyWhere:(UITapGestureRecognizer *) sender
{
    [self endEditing:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    [self endEditing:YES];
    return YES;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (arrFields.count * 2) - 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if((indexPath.row + 1) % 2 == 0){
        return 10;
    }
    return 50;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // set tableview separator inset to zero
    [tableView setSeparatorInset:(UIEdgeInsetsZero)];
    [tableView setLayoutMargins:(UIEdgeInsetsZero)];
    [cell setLayoutMargins:(UIEdgeInsetsZero)];
    
    if((indexPath.row + 1) % 2  == 0){
        [cell setBackgroundColor:[UIColor colorWithRed: 0.929 green: 0.922 blue: 0.91 alpha: 1]]; // cell Background color that will be blank
    }else{
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1 indexPath row for formatted form gap
    if((indexPath.row + 1) % 2  == 0){
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    DFFObject *field = [arrFields objectAtIndex:(indexPath.row/2)];
    
    if([field.widget  isEqual: @"EditText"]){
        
        DFFTextCell *cell = (DFFTextCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        
        cell = [cell initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"Cell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCellWithData:field cellIndexPath:indexPath]; // setup data to cell
        return cell;
        
        
        
    }else if([field.widget  isEqual: @"Button"]){
        DFFButtonCell *cell = (DFFButtonCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell3" forIndexPath:indexPath];
        
        cell = [cell initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"Cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setupCellWithData:field cellIndexPath:indexPath];  // setup data to cell
        return cell;
    }else if([field.widget  isEqual: @"CheckBox"]){
        DFFCheckBoxCell *cell = (DFFCheckBoxCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell4" forIndexPath:indexPath];
        
        cell = [cell initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"Cell4"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.showInViewController = self.showInViewController;
        [cell setupCellWithData:field cellIndexPath:indexPath];  // setup data to cell
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DFFObject *field = [arrFields objectAtIndex:indexPath.row/2];
    
    if([field.widget  isEqual: @"CheckBox"]){
        DFFCheckBoxCell *cell = (DFFCheckBoxCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        [cell showOptionView];
    }
    
}

// <ButtonCellDelegate> protocol method define

-(void) didPressButtonAtIndex:(DFFButtonCell *)cell indexPath:(NSIndexPath *)indexPath{
    DFFObject *field = [arrFields objectAtIndex:indexPath.row/2];
    if([field.action  isEqual: @"reset"]){
        [self reloadData];
    }
    
    NSMutableArray *submittedFormData = [[NSMutableArray alloc] init];
    
    if([field.action  isEqual: @"submit"]){
        
        int ind = 0; // Use it to cell index value
        
        for (DFFObject *_fieldData in arrFields) {
            
            NSIndexPath *makeIndexPath = [NSIndexPath indexPathForRow:(ind*2) inSection:0];
            
            
            if([_fieldData.widget  isEqual: @"EditText"]){
                
                
                DFFTextCell *cell = (DFFTextCell *)[self cellForRowAtIndexPath:makeIndexPath];
                
                UITextField *textField = (UITextField *)[cell viewWithTag:10];
                //NSLog(@"%@", textField.text);
                
                
                // Validate rule
                BOOL required = [_fieldData.validation_rules[@"required"] boolValue];
                BOOL check_validity = [_fieldData.validation_rules[@"check_validity"] boolValue];
                
                if([textField.text  isEqual: @""] && required){
                    cell.textLabel.textColor = [UIColor redColor];
                    
                    NSString *errorValidationMsg = _fieldData.validation_rules[@"error_message"];
                    [self showErrorAlert:errorValidationMsg callback:^{
                        [textField becomeFirstResponder]; // Focus back to text field for re-enter value
                    }];
                    
                    
                    return;
                }else{
                    cell.textLabel.textColor = _fieldData.color;
                }
                
                if([_fieldData.input_type  isEqual: @"textEmailAddress"] && check_validity){
                    NSString *regexForEmail = @"[a-zA-Z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; // email format regex
                    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexForEmail];
                    
                    BOOL is_valid = [emailTestPredicate evaluateWithObject:textField.text];
                    
                    if(!is_valid){
                        cell.textLabel.textColor = [UIColor redColor];
                        NSString *errorValidationMsg = _fieldData.validation_rules[@"error_message"];
                        
                        
                        [self showErrorAlert:errorValidationMsg callback:^{
                            [textField becomeFirstResponder]; // Focus back to text field for re-enter email value
                        }];
                        
                        
                        return;
                    }else{
                        cell.textLabel.textColor = _fieldData.color;
                    }
                }
                
                NSString *textFieldText = [NSString stringWithFormat:@"%@", textField.text];
                
                NSDictionary *valueDict = @{@"name":_fieldData.hint, @"value":textFieldText};
                
                [submittedFormData addObject:valueDict];
                
                
                
            }
            
            if([_fieldData.widget  isEqual: @"CheckBox"]){
                
                DFFCheckBoxCell *cell = (DFFCheckBoxCell *)[self cellForRowAtIndexPath:makeIndexPath];
                
                BOOL required = [_fieldData.validation_rules[@"required"] boolValue];
                
                if(cell.selectedOptionValues.count < 1 && required){
                    cell.textLabel.textColor = [UIColor redColor];
                    
                    NSString *errorValidationMsg = _fieldData.validation_rules[@"error_message"];
                    [self showErrorAlert:errorValidationMsg callback:^{
                        [cell showOptionView]; // Show checklist for select option.
                    }];
                    
                    
                    return;
                }else{
                    cell.textLabel.textColor = _fieldData.color;
                }
                
                
                NSDictionary *valueDict = @{@"name":_fieldData.hint, @"value":cell.selectedOptionValues};
                
                [submittedFormData addObject:valueDict];
                
            }
            
            ind++; // Increament cell index value
        }
        
        // NSLog(@"%@", submittedFormData);
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:submittedFormData options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [_fdelegate submittedData:jsonString];
        
        [self reloadData];
        
        
        
    }
}

/**
 *  Alert Method:
 *  showErrorAlert: For show alert for error in form validation. it taking 2 arguments, first one is message string and second one is callback for handler method for focus back to error element.
 */

-(void) showErrorAlert:(NSString *) msg callback:(void (^)(void))callback{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionDismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        callback();
    }];
    
    [alert addAction:actionDismiss];
    
    [_showInViewController presentViewController:alert animated:YES completion:nil];
    
}


@end
