//
//  ViewController.h
//  shoe
//
//  Created by taufiq on 3/5/14.
//  Copyright (c) 2014 TfqNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataTable,DBController;
@interface ViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIImageView *imgSaved;
@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* StoreData;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionV;
@end
