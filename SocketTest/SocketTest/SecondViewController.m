//
//  SecondViewController.m
//  SocketTest
//
//  Created by 我叫MT on 17/3/31.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "SecondViewController.h"
#import "AsyncSocketManager.h"
@interface SecondViewController ()<UITextFieldDelegate>
{
    UITextField *textField;
}
@property(nonatomic, copy)NSString *magg;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    textField = [[UITextField alloc]init];
    [self.view addSubview:textField];
    textField.frame = CGRectMake(100 , 100, 200, 50);
    textField.layer.borderColor = [UIColor magentaColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.delegate = self;
    
    UIButton *button = [[UIButton alloc]init];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 200, 100, 50);
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(fasong) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    UIButton *oneButton = [[UIButton alloc]init];
    [self.view addSubview:oneButton];
    oneButton.frame = CGRectMake(100, 300, 100, 50);
    oneButton.backgroundColor = [UIColor greenColor];
    [oneButton setTitle:@"连接" forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(lianjie) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)text
{
    NSLog(@"%@",text.text);
    _magg = text.text;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


-(void)fasong
{
    [textField resignFirstResponder];
    if (_magg) {
        AsyncSocketManager *manager = [AsyncSocketManager shareManager];
        [manager sendMsg:_magg];
    }
    
}

-(void)lianjie
{
    [[AsyncSocketManager shareManager]connect];
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

@end
