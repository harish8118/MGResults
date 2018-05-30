//
//  FindOutVC.m
//  MGResults
//
//  Created by macmini on 6/8/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import "FindOutVC.h"
#import "ResultVC.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "greatResultVC.h"

@interface FindOutVC (){
    NSMutableArray*reslt;
    AppDelegate*app;
    UIActivityIndicatorView *activityView;
}

@end

@implementation FindOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    reslt=[NSMutableArray new];
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    activityView= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.color=[UIColor blackColor];
    activityView.center=self.view.center;
    [self.view addSubview:activityView];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_hallTicketNmbr) {
        if ((_hallTicketNmbr.text.length<14)||([string isEqualToString:@""])) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)GoResultAction:(UIButton *)sender {
    if (_hallTicketNmbr.text.length==12) {
        [activityView startAnimating];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:[NSString stringWithFormat:@"http://103.231.100.207/Host/api/MG/GET?id=%@&mob=%@&email=%@",self.hallTicketNmbr.text,@"0",@"0"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            reslt=(NSMutableArray*)responseObject;
            if (reslt.count>0) {
                [app.result removeAllObjects];
                NSLog(@"%@",app.result);
                app.result=[reslt mutableCopy];
                ResultVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultVC"];
                [activityView stopAnimating];
                [self presentViewController:vc animated:YES completion:nil];
                vc.halliTicket.text=[[reslt objectAtIndex:0]objectForKey:@"Htno"];
                vc.stdntName.text=[[reslt objectAtIndex:0]objectForKey:@"Sname"];
                vc.course.text=[[reslt objectAtIndex:0]objectForKey:@"Course"];
                vc.Offline.hidden=YES;
                vc.homeButton.hidden=NO;
            }else{
                [activityView stopAnimating];
                UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"ALERT" message:@"Please Enter Valid HallTicket Number." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            NSLog(@"%@",reslt);
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
            NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
            if (myStatus == NotReachable)
            {
                [activityView stopAnimating];
                UIAlertController*alrt=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please connect with internet." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alrt addAction:ok];
                [self presentViewController:alrt animated:YES completion:nil];
            }
            NSLog(@"Error: %@", error);
            
        }];
    }else if (_hallTicketNmbr.text.length==14) {
        [activityView startAnimating];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:[NSString stringWithFormat:@"http://103.231.100.207/Host/api/MG/GET?id=%@&mob=%@&email=%@",self.hallTicketNmbr.text,@"0",@"0"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            reslt=(NSMutableArray*)responseObject;
            if (reslt.count>0) {
                [app.result removeAllObjects];
                NSLog(@"%@",app.result);
                app.result=[reslt mutableCopy];
                ResultVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultVC"];
                [activityView stopAnimating];
                [self presentViewController:vc animated:YES completion:nil];
                vc.halliTicket.text=[[reslt objectAtIndex:0]objectForKey:@"Htno"];
                vc.stdntName.text=[[reslt objectAtIndex:0]objectForKey:@"Sname"];
                vc.course.text=[[reslt objectAtIndex:0]objectForKey:@"Course"];
                vc.Offline.hidden=YES;
                vc.homeButton.hidden=NO;
            }else{
                [activityView stopAnimating];
                UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"ALERT" message:@"Please Enter Valid HallTicket Number." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            NSLog(@"%@",reslt);
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
            NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
            if (myStatus == NotReachable)
            {
                [activityView stopAnimating];
                UIAlertController*alrt=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please connect with internet." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alrt addAction:ok];
                [self presentViewController:alrt animated:YES completion:nil];
            }
            NSLog(@"Error: %@", error);
            
        }];
    }else{
        UIAlertController*alrt=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Valid HallTicket Number." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alrt addAction:ok];
        [self presentViewController:alrt animated:YES completion:nil];
    }

}

- (IBAction)BackAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
