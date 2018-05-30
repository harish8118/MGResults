//
//  ResultVC.h
//  MGResults
//
//  Created by macmini on 6/8/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *stdntName;
@property (weak, nonatomic) IBOutlet UILabel *halliTicket;
@property (weak, nonatomic) IBOutlet UILabel *course;
@property (weak, nonatomic) IBOutlet UITableView *resultTable;
@property NSMutableArray*result;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UILabel *Offline;
- (IBAction)Home:(UIButton *)sender;

- (IBAction)CloseApp:(UIButton *)sender;
@end
