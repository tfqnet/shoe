//
//  DetailViewController.m
//  shoe
//
//  Created by taufiq on 3/10/14.
//  Copyright (c) 2014 TfqNet. All rights reserved.
//

#import "DetailViewController.h"
#import "DataTable.h"
#import "DBController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.db = [DBController sharedDatabaseController:@"shoeTesting.sqlite"];
    
    NSString *str = [NSString stringWithFormat:@"SELECT * FROM shoetbl where id = %d",_fileId.intValue];
    
    _StoreData = [_db  ExecuteQuery:str];
    
    NSLog(@"DB: %@",_StoreData.rows);
    NSString *imgStr;
    
    for (NSArray* row in _StoreData.rows){
        
        _txtBrand.text = [row objectAtIndex:2];
        imgStr = [row objectAtIndex:1];
        _txtType.text = [row objectAtIndex:3];
        _txtColor.text = [row objectAtIndex:5];
        _txtSize.text = [[row objectAtIndex:4]stringValue];
        _txtDetail.text = [row objectAtIndex:6];
        
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:imgStr];
    
    //
    UIImage *imgV = [UIImage imageWithContentsOfFile:path];
    
    _imgView.image = imgV;

    
    
    UIBarButtonItem *Close = [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(btnClose:)];
    self.navigationItem.rightBarButtonItem = Close;
    
    
    
    
    
	// Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
}


- (IBAction)btnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
