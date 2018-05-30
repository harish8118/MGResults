//
//  greatResultVC.h
//  MGResults
//
//  Created by macmini on 6/9/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface greatResultVC : UIViewController<UITableViewDataSource,UITextFieldDelegate>
- (IBAction)home:(UIButton *)sender;
- (IBAction)closeAct:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *stdntName;
@property (weak, nonatomic) IBOutlet UILabel *hallTicketNumber;
@property (weak, nonatomic) IBOutlet UILabel *course;
@property (weak, nonatomic) IBOutlet UILabel *offline;
@property (weak, nonatomic) IBOutlet UITableView *greadResultTable;
@property NSMutableArray*result;
@property (strong, nonatomic) IBOutlet UIButton *homeButton;

@end
