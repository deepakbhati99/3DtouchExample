//
//  MasterViewController.m
//  viewAnimations
//
//  Created by Himanshu Khatri on 1/12/16.
//  Copyright © 2016 bd 001. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    


    

    self.objects = [[NSMutableArray alloc] initWithArray:@[@"simple Animation Block",@"Animation with Bounce",@"Animation With Transition",@"Pulse",@"Shake",@"Border Animations"]];

}


-(void)showAnimation:(NSNotification *)notification{
    
    NSDictionary *noti=notification.userInfo;
    
//    UITableViewCell *cell=[self tableView:self.tableView cellForRowAtIndexPath:noti[@"selectedIndexPath"]];
    [self.tableView selectRowAtIndexPath:noti[@"selectedIndexPath"] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    

}
- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = YES;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath;
    if ([[segue identifier] isEqualToString:@"showDetail"])//||[[segue identifier] isEqualToString:@"showPreview"]) {
    {
        
        indexPath=[self.tableView indexPathForSelectedRow];


    }else{
        indexPath=[self.tableView indexPathForCell:sender];
    }
    
    NSDate *object = self.objects[indexPath.row];
    DetailViewController *controller = (DetailViewController *)[segue destinationViewController] ;
    [controller setDetailItem:object];
    controller.x=indexPath.row;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}



@end
