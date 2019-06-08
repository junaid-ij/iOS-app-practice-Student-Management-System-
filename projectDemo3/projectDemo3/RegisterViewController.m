//
//  RegisterViewController.m
//  projectDemo3
//
//  Created by Admin on 12/11/18.
//  Copyright © 2018 Mac Lab. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize fname,lname,email,contact,age,gender,pass,status;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *docsDir;
    NSArray *dirPaths;
    //    get the document directory
    dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir=[dirPaths objectAtIndex:0];
    
    //    Build the path to the database file
    databasePath=[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"contacts.db"]];
    NSLog(@"%@",databasePath);
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    //if ([fileManager fileExistsAtPath:databasePath]) {
        const char *dbpath=[databasePath UTF8String];
        //        sqlite3_open: This function is used to create and open a database file. It accepts two parameters, where the first one is the database file name, and the second a handler to the database. If the file does not exist, then it creates it first and then it opens it, otherwise it just opens it.
        //if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK) {
    
            sqlite3_open(dbpath, &contactDB);
            char *errMsg;
            const char *sql_stmt="CREATE TABLE IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT, FNAME TEXT, LNAME TEXT, EMAIL TEXT, CONTACT TEXT,AGE TEXT, GENDER TEXT , PASS TEXT)";
        sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);
            NSLog(@"contacts table CREATED");
        
        
        //char *errMsg;
        sql_stmt="CREATE TABLE IF NOT EXISTS CURRENTCOURSES(ID INTEGER PRIMARY KEY AUTOINCREMENT, COURSE1 TEXT, COURSE2 TEXT, COURSE3 TEXT, COURSE4 TEXT)";
        
        sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);
        NSLog(@"COURSES TABLE CREATED");

            //            that allows an application to run multiple statements of SQL without having to use a lot of C code.
        
            sqlite3_close(contactDB);
       // }
    
    
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

- (IBAction)register:(UIButton *)sender {
    sqlite3_stmt *statement;
    const char *dbpath=[databasePath UTF8String];
    if (sqlite3_open(dbpath, &contactDB) ==SQLITE_OK)
    {
        NSString *insertSQL=[NSString stringWithFormat:@"INSERT INTO CONTACTS (fname,lname,email,contact,age,gender,pass) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",fname.text,lname.text,email.text,contact.text,age.text,gender.text,pass.text];
        const char *insert_stmt = [insertSQL UTF8String];
        //        sqlite3_prepare_v2: The purpose of this function is to get a SQL statement (a query) in string format, and convert it to an executable format recognizable by SQLite 3.
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        NSLog(@"CONTACT ADDED");
        //        sqlite3_step: This function actually executes a SQL statement (query) prepared with the previous function. It can be called just once for executable queries (insert, update, delete), or multiple times when retrieving data. It’s important to have in mind that it can’t be called prior to the sqlite3_preprare_v2 function.
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"statement done");
            status.text=@"Contact added";
            fname.text=@"";
            lname.text=@"";
            email.text=@"";
            contact.text=@"";
            age.text=@"";
            gender.text=@"";
            pass.text=@"";
            
        }
        else
        {
            status.text=@"Failed to add contact";
        }
        //        sqlite3_finalize: It deletes a prepared statement from memory.
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        NSLog(@"reg closed");
    }

}
@end
