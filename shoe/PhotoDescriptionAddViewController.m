//
//  PhotoDescriptionAddViewController.m
//  shoe
//
//  Created by taufiq on 3/5/14.
//  Copyright (c) 2014 TfqNet. All rights reserved.
//

#import "PhotoDescriptionAddViewController.h"
#import "DataTable.h"
#import "DBController.h"


@interface PhotoDescriptionAddViewController ()

@end

@implementation PhotoDescriptionAddViewController

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
    
    UIBarButtonItem *Done = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(btnAdd:)];
    self.navigationItem.rightBarButtonItem = Done;

    
	// Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    NSString *rawString = [textField text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Empty Field(s)" message:@"Are you sure to continue?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alert.tag = 1;
        [alert show];
    }

    
    return YES;
}

-(BOOL)TextValidation{
    
    for(UITextField *txtField in self.scrollView.subviews)
    {
        if([txtField isKindOfClass:[UITextField class]])
        {
            NSString *rawString = [txtField text];
            NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
            if ([trimmed length] == 0) {
                if(!alrt){
                // Text was empty or only whitespace.
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Empty Field(s)" message:@"Are you sure to continue?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                alert.tag = 1;
                [alert show];
                    alrt = YES;
                    return  NO;
                }
            }
            
        }
    }
    
    
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
    { alrt = NO;

        if(buttonIndex== 1)
        {
            alrt = YES;
            [self btnAdd:self];
        }
        
    }
}

- (IBAction)btnAdd:(id)sender {
    
    
    if([self TextValidation]){
    
    
        NSDate *date = [NSDate date];
    
    
        NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
    
        //NSTimeZone *gmt = ;
    
        [dateF setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        [dateF setDateFormat:@"yyyyMMddHHmmss"];
        NSString *keytsValue;
        keytsValue = [NSString stringWithFormat:@"%@.png",[dateF stringFromDate:date]];
        NSString *keytsValueThumb;
        keytsValueThumb = [NSString stringWithFormat:@"%@thumb.png",[dateF stringFromDate:date]];

        _favourite = [NSString stringWithFormat:@"YES"];
        
        
        NSString *str = [NSString stringWithFormat:@"INSERT INTO shoetbl(timestamp, thumbnailimgts, brand, type, size, color, description, favourite) VALUES('%@', '%@', '%@', '%@', %d, '%@', '%@', '%@')",keytsValue,keytsValueThumb,_txtBrand.text,_txtType.text,_txtSize.text.intValue,_txtColor.text,_txtDetail.text, _favourite];
    
        int DBID;

        DBID = [_db  ExecuteINSERT:str];
    
        NSLog(@"str %@",str);

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
        NSString *documentsDirectory = [paths objectAtIndex:0];
    
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:keytsValue];
        
        
        NSString *savedImagePathThumb = [documentsDirectory stringByAppendingPathComponent:keytsValueThumb];
    
        UIImage *image = _imgShoe.image; // imageView is my image from camera
    
        CGSize thumbNailSize = CGSizeMake(204.0,204.0);
        
        UIImage *imageThumb = [self imageWithImage:_imgShoe.image scaledToSize:thumbNailSize];
        
        
        NSData *imageData = UIImagePNGRepresentation(image);
        
        NSData *imageThumbData = UIImagePNGRepresentation(imageThumb);
        
        [imageThumbData writeToFile:savedImagePathThumb atomically:NO];
   
        [imageData writeToFile:savedImagePath atomically:NO];
        
        
        [[[self presentingViewController] presentingViewController]  dismissViewControllerAnimated:YES completion:nil];
        

    
    }
    

}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}




@end
