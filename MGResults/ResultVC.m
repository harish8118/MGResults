//
//  ResultVC.m
//  MGResults
//
//  Created by macmini on 6/8/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import "ResultVC.h"
#import "resultHead.h"
#import "resltCell.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Reachability.h"

@interface ResultVC ()
{
    NSMutableArray*first,*second,*third,*temp;
    AppDelegate*app;
    NSArray*Dup;
    int h;
    NSUInteger duplicates;
    NSMutableDictionary *mutDic;
}

@end

@implementation ResultVC
@synthesize result;

-(void)loadView{
    [super loadView];
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    result=[NSMutableArray new];
    temp=[NSMutableArray new];
    first=[NSMutableArray new];
    second=[NSMutableArray new];
    third=[NSMutableArray new];
    h=0;
    _homeButton.hidden=YES;
    _stdntName.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Sname"];
    _halliTicket.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Htno"];
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
    resltCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableArray*arr=[NSMutableArray new];
    for (int j=0; j<temp.count; j++)
    {
        if ([[Dup objectAtIndex:indexPath.section] isEqualToString:[temp objectAtIndex:j]]) {
            [arr addObject:[app.result objectAtIndex:j]];
        }
    }
    
    cell.stName.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row]objectForKey:@"Subject"]];
    
    cell.type.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row]objectForKey:@"Passmarks"]];
    
    cell.marks.text=[[arr objectAtIndex:indexPath.row]objectForKey:@"Securedmarks"];
    
    cell.res.text=[NSString stringWithFormat:@"%@ ",[[arr objectAtIndex:indexPath.row]objectForKey:@"SubjectResult"]];
    
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
    NSArray*cellarry=[[NSBundle mainBundle]loadNibNamed:@"tableHead" owner:self options:nil];
    resultHead*call=[cellarry objectAtIndex:0];
    call.Tota.text=[NSString stringWithFormat:@"Total: %@",[[arr objectAtIndex:0]objectForKey:@"FinalTotal"]];
    call.year.text=[NSString stringWithFormat:@" %@",[[arr objectAtIndex:0]objectForKey:@"Year"]];
    call.result.text=[NSString stringWithFormat:@"Res: %@ ",[[arr objectAtIndex:0]objectForKey:@"Result"]];
    vw=call;
    
    return vw;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Home:(UIButton *)sender {
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

- (IBAction)CloseApp:(UIButton *)sender {
    exit(0);
}
@end
