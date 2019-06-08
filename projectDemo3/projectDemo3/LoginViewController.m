//
//  LoginViewController.m
//  projectDemo3
//
//  Created by Admin on 12/11/18.
//  Copyright © 2018 Mac Lab. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize login_email,login_pass,login_status,idcheck;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self login_work];
    //_u=10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(UIButton *)sender {
    [self login_work];
    NSLog(@"login worked");
  
}
-(void)login_work{
    
    NSString *docsDir;
    NSArray *dirPaths;
    //    get the document directory
    dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir=[dirPaths objectAtIndex:0];
    
    //    Build the path to the database file
    databasePath=[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"contacts.db"]];
    const char *dbpath=[databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT pass,id FROM contacts WHERE email=\"%@\"", login_email.text];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement)==SQLITE_ROW) {
         
                NSString *passCheck = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                idcheck = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSLog(@"id check is : %@",idcheck);
        
//                self.idcheck=sqlite3_column_int(statement, 1);
     
                if (login_pass.text!= passCheck) {
                    login_status.text=@"pass/email didn't match";
                    return;
                    
                }else{
                    [self performSegueWithIdentifier:@"login" sender:self];
                    
                    NSLog(@"matched");
                }
                
                
            }
            sqlite3_finalize(statement);
            NSLog(@"finalize");
        }
        sqlite3_close(contactDB);
        NSLog(@"db closed");
    }
}

//SINGLETON_FOR_CLASS(self);

+ (LoginViewController *)sharedInstance{
    static LoginViewController *sharedInstance = nil;
    static dispatch_once_t onceToken; // onceToken = 0
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LoginViewController alloc] init];
    });
    
    return sharedInstance;
}



@end
