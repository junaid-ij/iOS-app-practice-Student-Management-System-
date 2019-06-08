//
//  RegisterViewController.h
//  projectDemo3
//
//  Created by Admin on 12/11/18.
//  Copyright © 2018 Mac Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface RegisterViewController : UIViewController
{
    NSString * databasePath;
    sqlite3 *contactDB;
}

@property (strong, nonatomic) IBOutlet UITextField *fname;
@property (strong, nonatomic) IBOutlet UITextField *lname;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *contact;
@property (strong, nonatomic) IBOutlet UITextField *age;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *pass;
@property (strong, nonatomic) IBOutlet UILabel *status;
- (IBAction)register:(UIButton *)sender;

@end
