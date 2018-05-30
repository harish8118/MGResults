//
//  ViewController.h
//  MGResults
//
//  Created by macmini on 6/6/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "BSKeyboardControls.h"

@interface ViewController : UIViewController<UITextFieldDelegate,BSKeyboardControlsDelegate>
@property (weak, nonatomic) IBOutlet UITextField *htNmbr;
@property (weak, nonatomic) IBOutlet UITextField *mobileNmbr;
@property (weak, nonatomic) IBOutlet UITextField *emailID;
@property (weak, nonatomic) IBOutlet UIButton *signUp;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

- (IBAction)SignUpAction:(UIButton *)sender;
@end

