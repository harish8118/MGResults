//
//  gradeResultCell.h
//  MGResults
//
//  Created by macmini on 6/9/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gradeResultCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *code;
@property (strong, nonatomic) IBOutlet UILabel *subject;
@property (strong, nonatomic) IBOutlet UILabel *grade;
@property (strong, nonatomic) IBOutlet UILabel *credits;


@end
