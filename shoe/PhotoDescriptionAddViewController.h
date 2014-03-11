//
//  PhotoDescriptionAddViewController.h
//  shoe
//
//  Created by taufiq on 3/5/14.
//  Copyright (c) 2014 TfqNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"




@class DataTable,DBController;
@interface PhotoDescriptionAddViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    BOOL alrt;
    
}


@property (strong, nonatomic) IBOutlet UITextField *txtBrand;
@property (strong, nonatomic) IBOutlet UITextField *txtType;
@property (strong, nonatomic) IBOutlet UITextField *txtSize;

@property (strong, nonatomic) IBOutlet UITextField *txtColor;

@property (strong, nonatomic) IBOutlet UITextField *txtDetail;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;


@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* StoreData;
@property (strong, nonatomic) IBOutlet UIImageView *imgShoe;

@property (strong,nonatomic) NSString *favourite;
- (IBAction)btnAdd:(id)sender;
@end
