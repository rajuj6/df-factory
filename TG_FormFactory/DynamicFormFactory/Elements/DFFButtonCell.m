//
//  DFFButtonCell.m
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import "DFFButtonCell.h"

@interface DFFButtonCell ()
@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, strong) DFFObject *fieldData;
@property (nonatomic, strong) IBOutlet  UIButton *buttonField;
@end

@implementation DFFButtonCell

- (void)setupCellWithData:(DFFObject *)field cellIndexPath:(NSIndexPath *)cellIndexPath {
    
    self.fieldData = field;
    self.cellIndexPath = cellIndexPath;
    
    
    
    self.buttonField = [[UIButton alloc] initWithFrame:CGRectZero];
    
    [self.buttonField setTitle:field.text forState:UIControlStateNormal];
    [self.buttonField setTitleColor:_fieldData.color forState:UIControlStateNormal];
    [self.buttonField addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonField.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    self.buttonField.backgroundColor = [UIColor whiteColor];
    
    self.buttonField.tag = 10;
    
    [self.buttonField setEnabled: YES];
    
    [self.contentView addSubview:self.buttonField];
    
    self.buttonField.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *width =[NSLayoutConstraint constraintWithItem:self.buttonField attribute:NSLayoutAttributeWidth relatedBy:0 toItem:self.buttonField.superview attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    NSLayoutConstraint *height =[NSLayoutConstraint constraintWithItem:self.buttonField attribute:NSLayoutAttributeHeight relatedBy:0 toItem:self.buttonField.superview attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.buttonField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.buttonField.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.buttonField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.buttonField.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.f];
    
    [self.buttonField.superview addConstraint:width];
    [self.buttonField.superview addConstraint:height];
    [self.buttonField.superview addConstraint:top];
    [self.buttonField.superview addConstraint:leading];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)buttonPressed:(id)sender{
    [_delegate didPressButtonAtIndex:self indexPath:_cellIndexPath];
}
@end
