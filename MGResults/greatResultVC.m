//
//  greatResultVC.m
//  MGResults
//
//  Created by macmini on 6/9/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import "greatResultVC.h"
#import "greadHead.h"
#import "gradeResultCell.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Reachability.h"

@interface greatResultVC (){
    NSMutableArray*temp;
    AppDelegate*app;
    NSArray*Dup;
    int h;
    NSUInteger duplicates;
    NSMutableDictionary *mutDic;
}

@end

@implementation greatResultVC
@synthesize result;

-(void)loadView{
    [super loadView];
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    result=[NSMutableArray new];
    temp=[NSMutableArray new];
    
    h=0;
    _stdntName.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Sname"];
    _hallTicketNumber.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Htno"];
    _course.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Course"];
    NSLog(@"result %@",app.result);
    
    for (int i=0; i<app.result.count; i++) {
        [temp addObject:[[app.result objectAtIndex:i]objectForKey:@"Year"]];
    }
    NSLog(@" all Arrays %@",temp);
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:temp];
    Dup = [orderedSet array];
    NSLog(@" dup count %lu",(unsigned long)Dup.count);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSCountedSet *set = [[NSCountedSet alloc] initWithArray:temp];
    
    for (h=0; h<=Dup.count; h++) {
        if (section==h) {
            id object=[Dup objectAtIndex:h];
            duplicates=[set countForObject:object];
            //h++;
            NSLog(@"%lu",(unsigned long)duplicates);
            return duplicates;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    gradeResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    NSMutableArray*arr=[NSMutableArray new];
    for (int j=0; j<temp.count; j++)
    {
        if ([[Dup objectAtIndex:indexPath.section] isEqualToString:[temp objectAtIndex:j]]) {
            [arr addObject:[app.result objectAtIndex:j]];
        }
    }
    cell.code.text=[NSString stringWithFormat:@" %@",[[arr objectAtIndex:indexPath.row]objectForKey:@"Tcode"]];
    
    cell.subject.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row]objectForKey:@"Passmarks"]];
    
    cell.credits.text=[NSString stringWithFormat:@"%@    ",[[arr objectAtIndex:indexPath.row]objectForKey:@"Maxmarks"]];
    
    cell.grade.text=[NSString stringWithFormat:@"%@  ",[[arr objectAtIndex:indexPath.row]objectForKey:@"Securedmarks"]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [Dup count];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 61;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView*vw=[UIView new];
    NSMutableArray*arr=[NSMutableArray new];
    for (int j=0; j<temp.count; j++)
    {
        if ([[Dup objectAtIndex:section] isEqualToString:[temp objectAtIndex:j]]) {
            [arr addObject:[app.result objectAtIndex:j]];
        }
    }
    NSArray*cellarry=[[NSBundle mainBundle]loadNibNamed:@"gradeHead" owner:self options:nil];
    greadHead*call=[cellarry objectAtIndex:0];
    call.gpa.text=[NSString stringWithFormat:@"SGPA: %@",[[arr objectAtIndex:0]objectForKey:@"FinalTotal"]];
    
    if ([[[arr objectAtIndex:0]objectForKey:@"Year"] isEqualToString:@"1st Year"]) {
        call.sem.text=@" 1-Sem";
    }else if ([[[arr objectAtIndex:0]objectForKey:@"Year"] isEqualToString:@"2nd Year"]){
        call.sem.text=@" 2-Sem";
    }else if ([[[arr objectAtIndex:0]objectForKey:@"Year"] isEqualToString:@"3rd Year"]){
        call.sem.text=@" 3-Sem";
    }
    
    call.rslt.text=[NSString stringWithFormat:@"Res: %@ ",[[arr objectAtIndex:0]objectForKey:@"Result"]];
    vw=call;
    
    return vw;
}



- (IBAction)home:(UIButton *)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://103.231.100.207/Host/api/MG/GET?id=%@&mob=%@&email=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Htno"],@"0",@"0"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        result=(NSMutableArray*)responseObject;
        [app.result removeAllObjects];
        app.result=[result  mutableCopy];
        [self loadView];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
        NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
        if (myStatus == NotReachable)
        {
            UIAlertController*alrt=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please connect with internet." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alrt addAction:ok];
            [self presentViewController:alrt animated:YES completion:nil];
        }
        
        NSLog(@"Error: %@", error);
    }];
    

}

- (IBAction)closeAct:(UIButton *)sender {
    exit(0);
}
@end
