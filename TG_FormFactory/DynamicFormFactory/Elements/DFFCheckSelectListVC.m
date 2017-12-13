//
//  DFFCheckSelectListVC.m
//  TG_FormFactory
//
//  Created by Raju Jangid on 22/08/16.
//  Copyright © 2016 Tagove Limited. All rights reserved.
//

#import "DFFCheckSelectListVC.h"

@interface DFFCheckSelectListVC ()
@property(nonatomic, strong) UITableView *optioTableView;
@end

@implementation DFFCheckSelectListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.optioTableView = [[UITableView alloc] init];
    
    self.optioTableView.frame = self.view.bounds;
    self.optioTableView.delegate = self;
    self.optioTableView.dataSource = self;
    
    [self.view addSubview:self.optioTableView];
    
    // Constraint for UITableView
    self.optioTableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *width =[NSLayoutConstraint constraintWithItem:self.optioTableView attribute:NSLayoutAttributeWidth relatedBy:0 toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    NSLayoutConstraint *height =[NSLayoutConstraint constraintWithItem:self.optioTableView attribute:NSLayoutAttributeHeight relatedBy:0 toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.optioTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.optioTableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.f];
    
    [self.view addConstraint:width];
    [self.view addConstraint:height];
    [self.view addConstraint:top];
    [self.view addConstraint:leading];
    
    //Resgister UITableViewCell class for ReuseIdentifier
    
    [self.optioTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"optionCell"];
    
    if(_selectedOptionValues == nil){
        _selectedOptionValues = [[NSMutableArray alloc] init];
    }
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(doneOptionSelection:)] animated:NO];
}

-(void)doneOptionSelection:(id) sender{
    [self.ldelegate setSelectedOption:_selectedOptionValues];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_optionValues count];
    
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // set tableview separator inset to zero
    [tableView setSeparatorInset:(UIEdgeInsetsZero)];
    [tableView setLayoutMargins:(UIEdgeInsetsZero)];
    [cell setLayoutMargins:(UIEdgeInsetsZero)];
    
    
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.90]; // cell Background color
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifire=@"CellHome";
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifire];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifire];
    
    
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifire];
    }
    
    NSString *optionValue = [_optionValues objectAtIndex:indexPath.row];
    
    cell.textLabel.text = optionValue;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSInteger isIndex = -1;
    
    if(_selectedOptionValues.count > 0){
        isIndex = [_selectedOptionValues indexOfObject:optionValue];
    }
    if(isIndex < 0 || isIndex > 100000){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *optionValue = [_optionValues objectAtIndex:indexPath.row];
    
    
    NSInteger isIndex = -1;
    
    if(_selectedOptionValues.count > 0){
        isIndex = [_selectedOptionValues indexOfObject:optionValue];
    }
    if(isIndex < 0 || isIndex > 100000){
        [_selectedOptionValues addObject:optionValue];
    }else{
        [_selectedOptionValues removeObjectAtIndex:isIndex];
    }
    
    [self.optioTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:(UITableViewRowAnimationNone)];
    
    
    
    
    
}


@end
