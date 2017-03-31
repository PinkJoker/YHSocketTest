//
//  AsyncSocketManager.m
//  SocketTest
//
//  Created by 我叫MT on 17/3/31.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "AsyncSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

static NSString *Khost = @"127.0.0.1";
static const uint16_t Kport = 6969;
@interface AsyncSocketManager ()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *gcdSocket;
}

@end
@implementation AsyncSocketManager

+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static AsyncSocketManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance initSocket];
        
    });
    return instance;
}

-(void)initSocket
{
    gcdSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}

#pragma mark --对外的一些接口
//建立连接
-(BOOL)connect
{
    return [gcdSocket connectToHost:Khost onPort:Kport error:nil];
}
//断开连接
-(void)disConnect
{
    [gcdSocket disconnect];
}

//发送消息
-(void)sendMsg:(NSString *)msg
{
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    //第二个参数,请求超时时间
    [gcdSocket writeData:data withTimeout:-1 tag:110];
}

//监听最新消息
-(void)pullMsg
{
    //监听读数据的代理 -1永远监听，不潮湿，但是只收一次消息
    //所以每次接收到的消息还需调用一次
    [gcdSocket readDataWithTimeout:-1 tag:110];//读取当前消息队列中的未读消息 （不调用这个方法，消息回调的代理永远不会被触发）
}
#pragma makr --GcdAsyncSocketDelegate
//连接成功调用
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功");
    [self pullMsg];
    //心跳
}
//断开连接调用
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"断开连接");
}
//成功的回调
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到的消息%@",msg);
    [self pullMsg];
}

//分段获取消息的回调
-(void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    NSLog(@"读的回调");
}
//为上一次设置的读取数据代理续时(如果设置超时未-1，则永远不会调用到)
-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
{
    NSLog(@"来延时");
    return 10;
}




@end
