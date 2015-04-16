//
//  ViewController.m
//  Lesson4
//
//  Created by Vasily on 12.04.15.
//  Copyright (c) 2015 Vasily Filippov. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "CastomTableViewCell.h"
#import "MakeArrayas.h"

@interface ViewController ()

@property(nonatomic, strong) NSMutableArray * arrayM;

@property(nonatomic, strong) MakeArrayas * makeArrays;


- (IBAction)backAction:(id)sender;

- (IBAction)first_ArrayAtion:(id)sender;

- (IBAction)another_ArrayAction:(id)sender;


@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    if (self.isFirstArray) {
        [self makeFirstArray];
        
    }
    
    else  {
        [self makeAnotherArray];
    }
}

- (void) makeFirstArray {

    MakeArrayas * makeArrayas = [[MakeArrayas alloc]init];
    [makeArrayas setDelegate:self];
    [makeArrayas makeFirstArray];
}

- (void) makeAnotherArray {

    MakeArrayas * makeArrayas = [[MakeArrayas alloc]init];
    [makeArrayas setDelegate:self];
    [makeArrayas makeAnotherArray];
    
}


-(void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can de recreated.
    
}

//=======================================================================

#pragma mark - UITableViewDelegate

-(void) reloadTableView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrayM.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    CastomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
    

    
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[[self.arrayM objectAtIndex:indexPath.row]objectForKey:@"value"]]];
    

        cell.label_ProductPrice.text = [[self.arrayM objectAtIndex: indexPath.row]objectForKey:@"value"];
        cell.label_ProductValue.text = [[self.arrayM objectAtIndex:indexPath.row]objectForKey:@"price"];
        
         NSLog(@"cell.label_ProductPrice.text %@", cell.label_ProductPrice.text);
    
    cell.imageView_ProductImage.image = image;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *  detal = [self.storyboard
                                     instantiateViewControllerWithIdentifier:@"Detail"];
    
    NSDictionary * dict = [self.arrayM objectAtIndex:indexPath.row];
    
    detal.string_MainValue = [dict objectForKey:@"value"];
    detal.string_Price = [dict objectForKey:@"price"];
    detal.string_Discr = [dict objectForKey:@"discr"];
    
    [self.navigationController pushViewController:detal animated:YES];
    
    NSLog(@"indexPath %li", (long)indexPath.row);
    
    } 
    



    

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)first_ArrayAtion:(id)sender {
    
    [self makeFirstArray];
     
    
}

- (IBAction)another_ArrayAction:(id)sender {
     [self makeAnotherArray];
    
}


    



    




//=============================================================================================================
#pragma mark - MakeArraysDelegate

- (void) makeArraysFirstArrayReady : (MakeArrayas *) makeArrays FirstArray: (NSMutableArray *) firstArray {
    
    [self reloadTableView ];
    [self.arrayM removeAllObjects];
    self.arrayM = firstArray;
    self.isFirstArray = YES;
   
    
}
- (void) makeArraysSecondArrayReady : (MakeArrayas *) makeArrays SecondArray: (NSMutableArray *) secondArray {
    
     [self reloadTableView ];
    [self.arrayM removeAllObjects];
    self.arrayM = secondArray;
    self.isFirstArray = NO;
   

}


@end