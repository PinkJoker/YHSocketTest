//
//  AsyncSocketManager.h
//  SocketTest
//
//  Created by 我叫MT on 17/3/31.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncSocketManager : NSObject

+(instancetype)shareManager;
-(BOOL)connect;
-(void)disConnect;
-(void)sendMsg:(NSString *)msg;
-(void)pullMsg;

@end
