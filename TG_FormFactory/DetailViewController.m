//
//  DetailViewController.m
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import "DetailViewController.h"
#import "DynamicFormFactory.h"

@interface DetailViewController () <DynamicFormFactoryDelegate>

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"Sample Form %lu", (unsigned long)(self.detailItemIndex.row+1)];
    
    NSString *jsonStr = @"";
    
    if (self.detailItemIndex.row == 0) {
        
        jsonStr = @"[{\"widget\":\"EditText\",\"input_type\":\"textCapWords\",\"hint\":\"First Name\",\"validation_rules\":{\"required\":true,\"min_length\":3,\"max_length\":20,\"error_message\":\"Please enter a valid first name\"}},{\"widget\":\"EditText\",\"input_type\":\"textCapWords\",\"hint\":\"Middle Name\",\"validation_rules\":{\"required\":false,\"min_length\":1,\"max_length\":20,\"error_message\":\"Please enter a valid middle name\"}},{\"widget\":\"EditText\",\"input_type\":\"textCapWords\",\"hint\":\"Last Name\",\"validation_rules\":{\"required\":true,\"min_length\":3,\"max_length\":20,\"error_message\":\"Please enter a valid last name\"}},{\"widget\":\"EditText\",\"input_type\":\"textEmailAddress\",\"hint\":\"Email Address\",\"validation_rules\":{\"required\":false,\"check_validity\":true,\"error_message\":\"Please enter a valid email address\"}},{\"widget\":\"Button\",\"text\":\"Create Account\",\"action\":\"submit\"},{\"widget\":\"Button\",\"text\":\"Clear Form\",\"action\":\"reset\"}]";
        
    }
    
    if (self.detailItemIndex.row == 1) {
        
        jsonStr = @"[{\"widget\":\"EditText\",\"input_type\":\"textCapWords\",\"hint\":\"First Name\",\"validation_rules\":{\"required\":true,\"min_length\":3,\"max_length\":20,\"error_message\":\"Please enter a valid first name\"}},{\"widget\":\"EditText\",\"input_type\":\"textCapWords\",\"hint\":\"Middle Name\",\"validation_rules\":{\"required\":false,\"min_length\":1,\"max_length\":20,\"error_message\":\"Please enter a valid middle name\"}},{\"widget\":\"EditText\",\"input_type\":\"textCapWords\",\"hint\":\"Last Name\",\"validation_rules\":{\"required\":true,\"min_length\":3,\"max_length\":20,\"error_message\":\"Please enter a valid last name\"}},{\"widget\":\"EditText\",\"input_type\":\"textEmailAddress\",\"hint\":\"Email Address\",\"validation_rules\":{\"required\":false,\"check_validity\":true,\"error_message\":\"Please enter a valid email address\"}},{\"widget\":\"EditText\",\"input_type\":\"textSecureEntry\",\"hint\":\"Password\",\"color\":\"#186467\",\"validation_rules\":{\"required\":true,\"min_length\":6,\"max_length\":26,\"error_message\":\"Please enter a strong password\"}},{\"widget\":\"CheckBox\",\"hint\":\"Select Topic\",\"color\":\"#96492d\",\"checklist_option\":[\"Sports\",\"Policies\",\"Gaming\",\"Film\",\"Book\",\"Law\",\"Celebrity\",\"Politics\",\"Music\",\"Lifestyle\",\"Fashion\",\"Events\",\"Other\"],\"validation_rules\":{\"required\":true,\"error_message\":\"Please select at least one option.\"}},{\"widget\":\"Button\",\"text\":\"Create Account\",\"action\":\"submit\"},{\"widget\":\"Button\",\"text\":\"Clear Form\",\"action\":\"reset\"}]";
        
    }
    
    [[[DynamicFormFactory alloc] init] showDynamicForm:jsonStr showInView:self withDelegate:self];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}



-(void) submittedData:(NSString *)jsonString{
    
    NSLog(@"%@", jsonString);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
