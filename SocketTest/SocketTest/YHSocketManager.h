//
//  YHSocketManager.h
//  SocketTest
//
//  Created by 我叫MT on 17/3/31.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>
//1.客户端调用socket(...)创建socket
//2.客户端调用connect(...)向服务器发起连接请求以建立连接
//3.客户端与服务器简历连接之后，通过send(...)/receive(...)向客户端发送或从客户端接收数据
//4.客户端调用close关闭socket
@interface YHSocketManager : NSObject

+(instancetype)shareManager;
-(void)connect;
-(void)disConnect;
-(void)sendMessage:(NSString *)mes;
@end
