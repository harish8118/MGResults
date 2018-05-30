//
//  FindOutVC.h
//  MGResults
//
//  Created by macmini on 6/8/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindOutVC : UIViewController<UITextFieldDelegate>
- (IBAction)GoResultAction:(UIButton *)sender;
- (IBAction)BackAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *hallTicketNmbr;

@end
