//
//  ViewController.m
//  projectDemo3
//
//  Created by MacBook Pro on 5/11/18.
//  Copyright © 2018 Mac Lab. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize pid,pname,pemail,pcontact;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)show{
    NSLog(@"opens contact table.......works begin.........");
    NSString *docsDir;
    NSArray *dirPaths;
    //    get the document directory
    dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir=[dirPaths objectAtIndex:0];
    
    //    Build the path to the database file
    databasePath=[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"contacts.db"]];
    
    
    
    //SEARCHING FOR CURRENT COURSES
    const char *dbpath=[databasePath UTF8String];
    sqlite3_stmt *statement;
   // NSLog(@"statement");
    //if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
    sqlite3_open(dbpath, &contactDB);
    //NSLog(@"inside if cond1.");
    LoginViewController *l= [[LoginViewController alloc]init];
    
    
    //LoginViewController* l=[LoginViewController sharedInstance];
    //l.idcheck;
    //NSLog(@" coure id check :  %@",l.idcheck);
    
    
    
    sqlite3_open(dbpath, &contactDB);
    //        NSString *querySQL = [NSString stringWithFormat:@"SELECT  course1,course2,course3,course4 FROM currentcourses INNER JOIN contacts ON contacts.id=currentcourses.id WHERE contacts.id=\"%d\"",[l.idcheck intValue]];
    NSString *querySQL = [NSString stringWithFormat:@"SELECT  fname,id,email,contact FROM contacts WHERE contacts.email=\"%@\"",l.login_email.text];
    const char *query_stmt = [querySQL UTF8String];
    NSLog(@"%s",query_stmt);
    //NSLog(@"l.id==  %@",l.idcheck);
    //if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
    //NSLog(@"inside if cond2.");
    sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL);
    if (sqlite3_step(statement)==SQLITE_ROW) {
        sqlite3_step(statement);
        NSLog(@"inside if cond3.");
        NSString *c1 = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
        pname.text=c1;
        NSLog(@"c1 found...... %@",c1);
        NSString *c2 = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
        pid.text=c2;
        NSString *c3 = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
        pemail.text=c3;
        NSString *c4 = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
        pcontact.text=c4;
        
        
    }//else{
    
    //  course1.text=@"not found";
    // }
    
    sqlite3_finalize(statement);
    //}
    sqlite3_close(contactDB);
    NSLog(@"db closed");
    //}
}


@end
