//
//  DetailViewController.h
//  shoe
//
//  Created by taufiq on 3/10/14.
//  Copyright (c) 2014 TfqNet. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DataTable,DBController;
@interface DetailViewController : UIViewController



@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* StoreData;

@property (strong,nonatomic) NSString *fileId;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UITextField *txtBrand;
@property (strong, nonatomic) IBOutlet UITextField *txtType;

@property (strong, nonatomic) IBOutlet UITextField *txtSize;

@property (strong, nonatomic) IBOutlet UITextField *txtColor;

@property (strong, nonatomic) IBOutlet UITextField *txtDetail;

@end
