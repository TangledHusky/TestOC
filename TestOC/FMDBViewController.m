//
//  FMDBViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/9.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "FMDBViewController.h"
#import "FMDB.h"

@interface FMDBViewController ()
@property (nonatomic,strong) FMDatabase  *db;

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addviews];
    
    
    //创建数据库
    [self initDB];
    
    for (int i = 0; i<10; i++) {
        NSString *sql = [NSString stringWithFormat:@"insert into t_testDB(name,age) values(lilei,%d);",i+10];
        [self updateTable:sql];
    }

}

-(void)addviews{
    UIButton *btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    btnSelect.backgroundColor = [UIColor lightGrayColor];
    [btnSelect setTitle:@"查询" forState:UIControlStateNormal];
    [btnSelect addTarget:self action:@selector(selectMyTable) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelect];
    
    UIButton *btnSelectCount = [[UIButton alloc] initWithFrame:CGRectMake(100, 140, 100, 30)];
    btnSelectCount.backgroundColor = [UIColor lightGrayColor];
    [btnSelectCount setTitle:@"查询数量" forState:UIControlStateNormal];
    [btnSelectCount addTarget:self action:@selector(selectMyTableCount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelectCount];
  

}

-(void)selectMyTable{

    [self selectTable:@"select * from t_testDB"];
}

-(void)selectMyTableCount{
    
    [self selectTableCount:@"select count(*) from t_testDB"];
}

//创建数据库
-(void)initDB{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"testDB.sqlite"];
    
    //创建数据库
    self.db = [FMDatabase databaseWithPath:path];
    
    //打开数据库
    if ([self.db open]) {
        NSLog(@"open success");
        BOOL suc = [self.db executeUpdate:@"create table if not exists t_testDB(id integer primary key autoincrement,name text null,age integer default 1)"];
        if (suc) {
            NSLog(@"create table success");
        }else{
            NSLog(@"create table error");
        }
        
        
    }else{
        NSLog(@"open error");
    }
    
}

//执行更新、插入、删除
-(void)updateTable:(NSString *)sql{
    BOOL suc = [self.db executeUpdate:@"insert into t_testDB(name,age) values(?,?);",@"lilei", @(arc4random_uniform(10))];
    if (suc) {
        NSLog(@"update table success");
    }else{
        NSLog(@"update table error");
    }
}


//执行查询
-(void)selectTable:(NSString *)sql{
    FMResultSet *result = [self.db executeQuery:sql];
    //while  千万不能写if  不然只有一条数据！！！！！
    while ([result next]) {
        int ID = [result intForColumn:@"id"];
        NSString *name = [result stringForColumn:@"name"];
        int age = [result intForColumn:@"age"];
        NSLog(@"id:%d  name:%@  age:%d",ID,name,age);
    }
    
}

//执行查询数量
-(void)selectTableCount:(NSString *)sql{
    NSInteger count = [self.db intForQuery:sql];
    NSLog(@"data count:%d",count);
    
}


/**
 用事物插入,写法如下

 不用事物，是每次插入都会执行一次：开始新事物->插入数据->提交事务
 用了事物，就是只有一次commit
 500条数据，比较下来：前者用了12s，后者只用了0.03s
 
 @param fromIndex <#fromIndex description#>
 @param useTransaction <#useTransaction description#>
 */
- (void)insertData:(int)fromIndex useTransaction:(BOOL)useTransaction
{
    [_db open];
    if (useTransaction) {
        [_db beginTransaction];
        BOOL isRollBack = NO;
        @try {
            for (int i = fromIndex; i<500+fromIndex; i++) {
                NSString *nId = [NSString stringWithFormat:@"%d",i];
                NSString *strName = [[NSString alloc] initWithFormat:@"student_%d",i];
                NSString *sql = @"INSERT INTO Student (id,student_name) VALUES (?,?)";
                BOOL a = [_db executeUpdate:sql,nId,strName];
                if (!a) {
                    NSLog(@"插入失败1");
                }
            }
        }
        @catch (NSException *exception) {
            isRollBack = YES;
            [_db rollback];
        }
        @finally {
            if (!isRollBack) {
                [_db commit];
            }
        }
    }else{
        for (int i = fromIndex; i<500+fromIndex; i++) {
            NSString *nId = [NSString stringWithFormat:@"%d",i];
            NSString *strName = [[NSString alloc] initWithFormat:@"student_%d",i];
            NSString *sql = @"INSERT INTO Student (id,student_name) VALUES (?,?)";
            BOOL a = [_db executeUpdate:sql,nId,strName];
            if (!a) {
                NSLog(@"插入失败2");
            }
        }
    }
    [_db close];
}

@end
