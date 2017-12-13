//
//  DFFObject.m
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import "DFFObject.h"

@implementation DFFObject

@synthesize widget;
@synthesize input_type;
@synthesize hint;
@synthesize text;
@synthesize color;
@synthesize action;
@synthesize validation_rules;

@synthesize checklist_option;

-(void)setData:(NSDictionary *)dict
{
    if (dict) {
        widget = [dict objectForKey:@"widget"];
        input_type = [dict objectForKey:@"input_type"];
        hint = [dict objectForKey:@"hint"];
        if([dict objectForKey:@"color"]){
            color = [DFFObject colorWithHexString:[dict objectForKey:@"color"]];
        }else if([widget  isEqual: @"Button"]){
            color = [UIColor blueColor];
        }else{
            color = [UIColor blackColor];
        }
        text = [dict objectForKey:@"text"];
        action = [dict objectForKey:@"action"];
        validation_rules = [dict objectForKey:@"validation_rules"];
        checklist_option = [dict objectForKey:@"checklist_option"];
    }
}

+ (UIColor *)colorWithHexString:(NSString *)hexColor{
    const char *cStr = [hexColor cStringUsingEncoding:NSASCIIStringEncoding];
    long col = strtol(cStr+1, NULL, 16);
    
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
    
}

@end
