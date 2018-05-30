//
//  ViewController.m
//  MGResults
//
//  Created by macmini on 6/6/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "ResultVC.h"
#import "AppDelegate.h"
#import "greatResultVC.h"
#import "SVProgressHUD.h"

@interface ViewController (){
    NSMutableArray*result;
    AppDelegate*app;
    
}


@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString*str=[[NSUserDefaults standardUserDefaults]valueForKey:@"Status"];
    if ([str isEqualToString:@"1"])
    {
        
        Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
        NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
        if (myStatus == NotReachable)
        {
            ResultVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultVC"];
            app.result=[[[NSUserDefaults standardUserDefaults]valueForKey:@"Json"] mutableCopy];
            [self presentViewController:vc animated:YES completion:nil];
            vc.Offline.hidden=NO;
            NSLog(@"results %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Json"]);
            
        }else{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:[NSString stringWithFormat:@"http://103.231.100.207/Host/api/MG/GET?id=%@&mob=%@&email=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Htno"],@"0",@"0"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                
                result=(NSMutableArray*)responseObject;
                ResultVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultVC"];
                [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"Json"];
                app.result=[result  mutableCopy];
                [self presentViewController:vc animated:YES completion:nil];
                vc.Offline.hidden=YES;
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            
        }
    }else if ([str isEqualToString:@"2"]){
        
        Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
        NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
        if (myStatus == NotReachable)
        {
            greatResultVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"greatResultVC"];
            app.result=[[[NSUserDefaults standardUserDefaults]valueForKey:@"Json"] mutableCopy];
            [self presentViewController:vc animated:YES completion:nil];
            vc.offline.hidden=NO;
            NSLog(@"results %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Json"]);
            
        }else{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:[NSString stringWithFormat:@"http://103.231.100.207/Host/api/MG/GET?id=%@&mob=%@&email=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Htno"],@"0",@"0"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                
                result=(NSMutableArray*)responseObject;
                greatResultVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"greatResultVC"];
                [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"Json"];
                app.result=[result  mutableCopy];
                [self presentViewController:vc animated:YES completion:nil];
                vc.offline.hidden=YES;
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            
        }
        [SVProgressHUD dismiss];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    result=[NSMutableArray new];
    self.htNmbr.layer.cornerRadius =self.htNmbr.frame.size.height /10;
    self.htNmbr.layer.masksToBounds = YES;
    self.mobileNmbr.layer.cornerRadius =self.mobileNmbr.frame.size.height /10;
    self.mobileNmbr.layer.masksToBounds = YES;
    self.emailID.layer.cornerRadius =self.emailID.frame.size.height /10;
    self.emailID.layer.masksToBounds = YES;
    self.signUp.layer.cornerRadius =self.signUp.frame.size.height /10;
    self.signUp.layer.masksToBounds = YES;
    
//    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    [toolBar setTintColor:[UIColor blueColor]];
//    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Quit" style:UIBarButtonItemStyleDone target:self action:@selector(resign)];
//    [toolBar setItems:[NSArray arrayWithObjects:done,nil]];
//    [_htNmbr setInputAccessoryView:toolBar];
//    [_mobileNmbr setInputAccessoryView:toolBar];
//    [_emailID setInputAccessoryView:toolBar];

    NSArray *fields = @[ self.htNmbr, self.mobileNmbr,
                         self.emailID];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    [self.keyboardControls setBarTintColor:[UIColor blackColor]];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    UIView *view;
    view = field.superview.superview.superview;
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self.view endEditing:YES];
}


-(void)resign{
    [_emailID resignFirstResponder];
    [_mobileNmbr resignFirstResponder];
    [_htNmbr resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_htNmbr) {
        if ((_htNmbr.text.length<14)||([string isEqualToString:@""])) {
            return YES;
        }else{
            return NO;
        }
    }else if (textField==_mobileNmbr){
        if ((_mobileNmbr.text.length<10)||([string isEqualToString:@""])) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

- (IBAction)SignUpAction:(UIButton *)sender {
    
    if (_htNmbr.text.length>11 && _mobileNmbr.text.length==10 && _emailID.text.length>0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:[NSString stringWithFormat:@"http://103.231.100.207/Host/api/MG/GET?id=%@&mob=%@&email=%@",self.htNmbr.text,_mobileNmbr.text,_emailID.text] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            result=(NSMutableArray*)responseObject;

            if (result.count>0) {
                ResultVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultVC"];
                [[NSUserDefaults standardUserDefaults]setValue:[[result objectAtIndex:0]objectForKey:@"Htno"] forKey:@"Htno"];
                [[NSUserDefaults standardUserDefaults]setValue:[[result objectAtIndex:0]objectForKey:@"Sname"] forKey:@"Sname"];
                [[NSUserDefaults standardUserDefaults]setValue:[[result objectAtIndex:0]objectForKey:@"Course"] forKey:@"Course"];
                [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"Json"];
                [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"Status"];
                app.result=[result  mutableCopy];
                [self presentViewController:vc animated:YES completion:nil];
                
            }else{
                UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"ALERT" message:@"Please Enter Valid Creditials" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            NSLog(@"%@",result);
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }else
    {
        UIAlertController*alrt=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Valid Details" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alrt addAction:ok];
        [self presentViewController:alrt animated:YES completion:nil];
    }

}
@end
