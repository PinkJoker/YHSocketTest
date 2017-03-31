//
//  ViewController.m
//  SocketTest
//
//  Created by 我叫MT on 17/3/29.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "ViewController.h"
#import <CocoaAsyncSocket/AsyncSocket.h>
#import "YHSocketManager.h"
@interface ViewController ()<AsyncSocketDelegate,UITextFieldDelegate>
{
    UITextField *textField;
}
@property(nonatomic, copy)NSString *magg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    AsyncSocket *socket = [[AsyncSocket alloc]initWithDelegate:self];
//    [socket connectToHost:@"www.baidu.com" onPort:80 error:nil];
//    [socket readDataWithTimeout:3 tag:1];
//    [socket writeData:[@"GET/HTTP/1.1\n\n" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:1];
//    
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /* 服务端代码 node.js
     var net = require('net');
     var HOST = '127.0.0.1';
     var PORT = 6969;
     
     // 创建一个TCP服务器实例，调用listen函数开始监听指定端口
     // 传入net.createServer()的回调函数将作为”connection“事件的处理函数
     // 在每一个“connection”事件中，该回调函数接收到的socket对象是唯一的
     net.createServer(function(sock) {
     
     // 我们获得一个连接 - 该连接自动关联一个socket对象
     console.log('CONNECTED: ' +
     sock.remoteAddress + ':' + sock.remotePort);
     sock.write('服务端发出：连接成功');
     
     // 为这个socket实例添加一个"data"事件处理函数
     sock.on('data', function(data) {
     console.log('DATA ' + sock.remoteAddress + ': ' + data);
     // 回发该数据，客户端将收到来自服务端的数据
     sock.write('You said "' + data + '"');
     });
     // 为这个socket实例添加一个"close"事件处理函数
     sock.on('close', function(data) {
     console.log('CLOSED: ' +
     sock.remoteAddress + ' ' + sock.remotePort);
     });
     
     }).listen(PORT, HOST);
     
     console.log('Server listening on ' + HOST +':'+ PORT);
     */
    
    

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
        YHSocketManager *manager = [YHSocketManager shareManager];
        [manager sendMessage:_magg];
    }
    
}

-(void)lianjie
{
    [[YHSocketManager shareManager]connect];
}

/**
 * In the event of an error, the socket is closed.
 * You may call "unreadData" during this call-back to get the last bit of data off the socket.
 * When connecting, this delegate method may be called
 * before"onSocket:didAcceptNewSocket:" or "onSocket:didConnectToHost:".
 **/
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"did read data");
}

/**
 * Called when a socket disconnects with or without error.  If you want to release a socket after it disconnects,
 * do so here. It is not safe to do that during "onSocket:willDisconnectWithError:".
 *
 * If you call the disconnect method, and the socket wasn't already disconnected,
 * this delegate method will be called before the disconnect method returns.
 **/
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    
}

/**
 * Called when a socket accepts a connection.  Another socket is spawned to handle it. The new socket will have
 * the same delegate and will call "onSocket:didConnectToHost:port:".
 **/
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    
}




/**
 * Called when a socket connects and is ready for reading and writing.
 * The host parameter will be an IP address, not a DNS name.
 **/
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{

    
    
}

//假设男性职工的人数为X人，女性职工的人数为Y人
//则男性近视职工人数为  1/10*X  女性职工的人数为 1/5Y - 3/10 Y
//则男性不近视职工人数为 X- 1/10X  女性职工的不近视则为 Y- 1/5Y 到Y - 3/10Y之间
//X+ Y = 30
//9/10X +4/5Y = 30 - 1/10X -1/5Y
// 9/10X+ 4/5 *(30-X) = 30- 1/10X - 1/5(30-X)
// 9/10X +24 - 4/5X = 30 - 1/10X - 6 + 1/5X
//X +3/5X


/**
 * Called when a socket has completed reading the requested data into memory.
 * Not called if there is an error.
 **/
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"did read data");
    NSString *message = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"message is:\n%@",message);
}

/**
 * Called when a socket has read in data, but has not yet completed the read.
 * This would occur if using readToData: or readToLength: methods.
 * It may be used to for things such as updating progress bars.
 **/
- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    
}

/**
 * Called when a socket has completed writing the requested data. Not called if there is an error.
 **/
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
}

/**
 * Called when a socket has written some data, but has not yet completed the entire write.
 * It may be used to for things such as updating progress bars.
 **/
- (void)onSocket:(AsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    
}

/**
 * Called after the socket has successfully completed SSL/TLS negotiation.
 * This method is not called unless you use the provided startTLS method.
 *
 * If a SSL/TLS negotiation fails (invalid certificate, etc) then the socket will immediately close,
 * and the onSocket:willDisconnectWithError: delegate method will be called with the specific SSL error code.
 **/
- (void)onSocketDidSecure:(AsyncSocket *)sock
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
