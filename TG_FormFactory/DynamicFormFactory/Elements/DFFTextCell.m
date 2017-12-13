//
//  DFFTextCell.m
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import "DFFTextCell.h"

@interface DFFTextCell ()
@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, strong) DFFObject *fieldData;
@property (nonatomic, strong)  UITextField *valueTextField;


@end

@implementation DFFTextCell

- (void)setupCellWithData:(DFFObject *)field cellIndexPath:(NSIndexPath *)cellIndexPath {
    
    self.fieldData = field;
    self.cellIndexPath = cellIndexPath;
    
    self.textLabel.text = field.hint;
    self.textLabel.textColor = _fieldData.color;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    self.valueTextField = [[UITextField alloc] initWithFrame:CGRectMake((mainWindow.frame.size.width / 2), 10, mainWindow.frame.size.width - (mainWindow.frame.size.width / 2), 30)];
    self.valueTextField.adjustsFontSizeToFitWidth = NO;
    self.valueTextField.textColor = _fieldData.color;
    self.valueTextField.placeholder = [NSString stringWithFormat:@"Enter %@", field.hint];
    
    self.valueTextField.returnKeyType = UIReturnKeyDone;
    
    self.valueTextField.keyboardType = UIKeyboardTypeDefault;
    self.valueTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.valueTextField.secureTextEntry = NO;
    
    if([_fieldData.input_type  isEqual: @"textCapWords"]){
        self.valueTextField.autocapitalizationType = UITextAutocapitalizationTypeWords; // auto capitalization word support
        
    }else if([_fieldData.input_type  isEqual: @"textEmailAddress"]){
        self.valueTextField.keyboardType = UIKeyboardTypeEmailAddress;
        self.valueTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        
    }else if([_fieldData.input_type  isEqual: @"textSecureEntry"]){
        self.valueTextField.secureTextEntry = YES;
        
    }else{
        self.valueTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        
    }
    
    self.valueTextField.backgroundColor = [UIColor whiteColor];
    self.valueTextField.textAlignment = NSTextAlignmentRight;
    self.valueTextField.tag = 10;
    self.valueTextField.delegate = self;
    
    self.valueTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
    [self.valueTextField setEnabled: YES];
    
    self.accessoryView = self.valueTextField;
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
    
}

- (void)orientationChanged:(NSNotification *)notification{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            self.valueTextField.frame = CGRectMake((mainWindow.frame.size.width / 2), 10, mainWindow.frame.size.width - (mainWindow.frame.size.width / 2) - 15, 30);
        }
            
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            self.valueTextField.frame = CGRectMake((mainWindow.frame.size.width / 2), 10, mainWindow.frame.size.width - (mainWindow.frame.size.width / 2) - 15, 30);
        }
            break;
        case UIInterfaceOrientationUnknown:break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    //self.detailTextLabel.text = @"";
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    BOOL required = [_fieldData.validation_rules[@"required"] boolValue];
    BOOL check_validity = [_fieldData.validation_rules[@"check_validity"] boolValue];
    
    if([textField.text  isEqual: @""] && required){
        self.textLabel.textColor = [UIColor redColor];
        _errorValidation = _fieldData.validation_rules[@"error_message"];
    }else{
        self.textLabel.textColor = _fieldData.color;
        _errorValidation = @"";
    }
    
    if([_fieldData.input_type  isEqual: @"textEmailAddress"] && check_validity){
        NSString *regexForEmail = @"[a-zA-Z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexForEmail];
        
        BOOL is_valid = [emailTestPredicate evaluateWithObject:textField.text];
        
        if(!is_valid){
            self.textLabel.textColor = [UIColor redColor];
            _errorValidation = _fieldData.validation_rules[@"error_message"];
        }else{
            self.textLabel.textColor = _fieldData.color;
            _errorValidation = @"";
        }
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    int minValue = [_fieldData.validation_rules[@"min_length"] intValue];
    int maxvalue = [_fieldData.validation_rules[@"max_length"] intValue];
    BOOL required = [_fieldData.validation_rules[@"required"] boolValue];
    
    if(textField.text.length > 0 && !required && maxvalue > 0){
        if((textField.text.length < minValue || textField.text.length > maxvalue )){
            self.textLabel.textColor = [UIColor redColor];
            _errorValidation = _fieldData.validation_rules[@"error_message"];
        }else{
            self.textLabel.textColor = _fieldData.color;
            _errorValidation = @"";
        }
        
        
    }else{
        self.textLabel.textColor = _fieldData.color;
        _errorValidation = @"";
    }
    
    if(textField.text.length >= maxvalue && ![string isEqual:@""] && maxvalue > 0){
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
