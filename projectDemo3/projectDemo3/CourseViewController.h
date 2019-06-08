//
//  CourseViewController.h
//  projectDemo3
//
//  Created by Admin on 14/11/18.
//  Copyright © 2018 Mac Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "LoginViewController.h"
@interface CourseViewController : UIViewController
{
    
    NSString * databasePath;
    sqlite3 *contactDB;
}
@property NSInteger var;
@property (strong, nonatomic) IBOutlet UILabel *course1;
@property (strong, nonatomic) IBOutlet UILabel *course2;
@property (strong, nonatomic) IBOutlet UILabel *course3;
@property (strong, nonatomic) IBOutlet UILabel *course4;

@end
