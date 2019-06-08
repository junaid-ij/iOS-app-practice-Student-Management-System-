//
//  LoginViewController.h
//  projectDemo3
//
//  Created by Admin on 12/11/18.
//  Copyright © 2018 Mac Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "RegisterViewController.h"

#define SINGLETON_FOR_CLASS(LginViewController);

@interface LoginViewController : UIViewController
{
    NSString * databasePath;
    sqlite3 *contactDB;
}

@property (strong, nonatomic) IBOutlet UITextField *login_email;
@property (strong, nonatomic) IBOutlet UITextField *login_pass;
@property (strong, nonatomic) IBOutlet UILabel *login_status;
@property NSString * idcheck;

//@property  NSInteger idcheck;
- (IBAction)login:(UIButton *)sender;


//- (id)init;




+ (LoginViewController *)sharedInstance ;

@end
