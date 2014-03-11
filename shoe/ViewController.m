//
//  ViewController.m
//  shoe
//
//  Created by taufiq on 3/5/14.
//  Copyright (c) 2014 TfqNet. All rights reserved.
//

#import "ViewController.h"
#import "PhotoDescriptionAddViewController.h"
#import "DataTable.h"
#import "DBController.h"
#import "collectionViewCell.h"
#import "DetailViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
        
    [self.collectionV registerNib:[UINib nibWithNibName:@"collectionViewCell" bundle:Nil] forCellWithReuseIdentifier:@"MyCell"];
    [self.view addSubview:_collectionV];
    
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
       
    self.db = [DBController sharedDatabaseController:@"shoeTesting.sqlite"];
     
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _StoreData = [_db  ExecuteQuery:@"SELECT * FROM shoetbl"];
    NSLog(@"data:%@",_StoreData.rows);
   

    [_collectionV reloadData];
    
}



- (IBAction)snap:(id)sender {
    UIActionSheet *actionPop = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Capture",@"Library", nil];
    
    [actionPop showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self takePhoto];
    }
    else if (buttonIndex==1)
    {
        [self selectPhoto];
    }
}

- (void)takePhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.parentViewController presentViewController:picker animated:YES completion:NULL];
    
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.parentViewController presentViewController:picker animated:YES completion:NULL];
    
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PhotoDescriptionAddViewController *pview = [storyboard instantiateViewControllerWithIdentifier:@"PhotoDescription"];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:pview];


  // [picker dismissViewControllerAnimated:YES completion:^{
        
        //pview.imgShoe.image = chosenImage;
        
        

   // }];
    [picker presentViewController:navController animated:YES completion:^{
        pview.imgShoe.image = chosenImage;

    }];
   // [picker presentViewController:pview animated:YES completion:nil];

    
            //[self.navigationController pushViewController: pview animated:YES];
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_StoreData.rows.count!=0) {
        return _StoreData.rows.count;
    }
    else
        return 0;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    collectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    
    
    
    NSArray* row = [_StoreData.rows objectAtIndex:indexPath.row];
    
   
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:[row objectAtIndex:8]];
    
    //
    UIImage *imgV = [UIImage imageWithContentsOfFile:path];
    
    cell.imgViewShoe.image = imgV;
    //[cell.imgViewShoe setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* row = [_StoreData.rows objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    
    dvc.fileId = [row objectAtIndex:0];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:dvc];
    
    [self presentViewController:navController animated:YES completion:nil];
    
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
       return CGSizeMake(102, 102);
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
