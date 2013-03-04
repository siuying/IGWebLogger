//
//  IGWebLogger.h
//  IGWebLogger
//
//  Created by Francis Chong on 13年3月4日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"
#import "WebSocket.h"
#import "IGWebLoggerWebSocket.h"

@interface IGWebLogger : DDAbstractLogger <DDLogger, DDLogFormatter>

@property (nonatomic, strong) NSMutableArray* webSockets;

+ (IGWebLogger *)sharedInstance;

- (void)addWebSocket:(IGWebLoggerWebSocket*)webSocket;
- (void)removeWebSocket:(IGWebLoggerWebSocket*)webSocket;

@end
