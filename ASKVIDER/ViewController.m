//
//  ViewController.m
//  ASKVIDER
//
//  Created by Suhaib IT on 2/6/19.
//  Copyright © 2019 Suhaib IT. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "TableViewCell.h"


@interface ViewController (){
}


@end
NSMutableArray *resultUserSearch;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // ProgressHUD     *hudView=[ProgressHUD sharedFetchManager];
  //  [hudView showHudProgressWithText:NSLocalizedString(@"LOADING...", nil) withView:self.view];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    //    [policy setValidatesDomainName:NO];
    //    [policy setAllowInvalidCertificates:YES];
    //    [policy setValidatesCertificateChain:NO];
    //    manager.securityPolicy = policy;
    [manager.requestSerializer setTimeoutInterval:15];
    NSString *url = @"http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=d5SdKYUipQNhOAGpTT6SN3id1SiACIwr";
    
    
    
    //NSDictionary  *parameters = [NSDictionary dictionaryWithObjectsAndKeys:secretKey, @"secKey",@"list_all_deals",@"type",[[NSUserDefaults standardUserDefaults] objectForKey:@"customerId"],@"customerId",@"1",@"deal_type",nil];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer =responseSerializer;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         resultUserSearch=(NSMutableArray *)responseObject[@"results"];
        //NSLog(@"%@",[resultUserSearch valueForKey:@"details"]);
        [_tableView reloadData];
//        if([responseObject[@"@attributes"][@"status"] isEqualToString:@"Success"]){
//
//
//
//        }
        
     //   [hudView hideHudProgress];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@, %@", error, operation.responseString);
        
       // [hudView hideHudProgress];
        
        
        //        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Message",nil) message:NSLocalizedString(@"Some error ocurred",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        //        [alertView show];
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultUserSearch count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *CellIdentifier = @"CellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    static NSString *simpleTableIdentifier = @"TableViewCell";
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSLog(@"%@",[[resultUserSearch objectAtIndex:indexPath.row]valueForKey:@"city"]);
    cell.nameLabel.text=[[resultUserSearch objectAtIndex:indexPath.row]valueForKey:@"title"];
    cell.detailLabel.text=[[resultUserSearch objectAtIndex:indexPath.row]valueForKey:@"abstract"];
    cell.dateLabel.text=[[resultUserSearch objectAtIndex:indexPath.row]valueForKey:@"published_date"];
    
    
    NSString *url=[[[[[[resultUserSearch objectAtIndex:indexPath.row]valueForKey:@"media"]objectAtIndex:0]valueForKey:@"media-metadata"]objectAtIndex:1]valueForKey:@"url"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    cell.imageView.image = [UIImage imageWithData:imageData];
    //[cell.imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //did select action
    
}
@end
