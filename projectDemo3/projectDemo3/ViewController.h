//
//  ViewController.h
//  projectDemo3
//
//  Created by MacBook Pro on 5/11/18.
//  Copyright © 2018 Mac Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface ViewController : UIViewController
{
    NSString * databasePath;
    sqlite3 *contactDB;
}
@property (strong, nonatomic) IBOutlet UILabel *pname;
@property (strong, nonatomic) IBOutlet UILabel *pid;
@property (strong, nonatomic) IBOutlet UILabel *pemail;
@property (strong, nonatomic) IBOutlet UILabel *pcontact;

@end

