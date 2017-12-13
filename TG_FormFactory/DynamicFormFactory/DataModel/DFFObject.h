//
//  DFFObject.h
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

//  Model for form field data object.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DFFObject : NSObject
@property(nonatomic,copy)NSString *widget;
@property(nonatomic,copy)NSString *input_type;
@property(nonatomic,copy)NSString *hint;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)UIColor *color;
@property(nonatomic,copy)NSString *action;
@property(nonatomic,copy) NSDictionary *validation_rules;

//Option for checkbox
@property(nonatomic,copy)NSArray *checklist_option;

-(void)setData:(NSDictionary *)dict;

@end

