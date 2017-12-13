//
//  DFFCheckBoxCell.m
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import "DFFCheckBoxCell.h"
#import "DFFCheckSelectListVC.h"

@interface DFFCheckBoxCell()<DFFSelectOptionDelegate>

@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, strong) DFFObject *fieldData;


@end

@implementation DFFCheckBoxCell

- (void)setupCellWithData:(DFFObject *)field cellIndexPath:(NSIndexPath *)cellIndexPath {
    
    self.fieldData = field;
    self.cellIndexPath = cellIndexPath;
    self.selectedOptionValues = [[NSMutableArray alloc] init];
    self.textLabel.text = field.hint;
    self.textLabel.textColor = _fieldData.color;
    self.detailTextLabel.text = @"";
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) showOptionView{
    DFFCheckSelectListVC *listForSelectVC = [[DFFCheckSelectListVC alloc] init];
    
    listForSelectVC.optionValues = _fieldData.checklist_option;
    listForSelectVC.ldelegate = self;
    listForSelectVC.selectedOptionValues = self.selectedOptionValues;
    [self.showInViewController.navigationController pushViewController:listForSelectVC animated:YES];
}

-(void)setSelectedOption:(NSMutableArray *)selectedArr{
    self.selectedOptionValues = selectedArr;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%lu Values", (unsigned long)selectedArr.count ];
}

@end

