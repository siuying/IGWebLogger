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
#import "HTTPServer.h"
#import "IGWebLoggerWebSocket.h"

@interface IGWebLogger : DDAbstractLogger <DDLogger, DDLogFormatter>

@property (nonatomic, strong) NSMutableArray* webSockets;

// shared logger instance
+ (IGWebLogger *)sharedInstance;

// Create a new HTTPServer instance for the logger at port 8888
+ (HTTPServer*) httpServer;

// Create a new HTTPServer instance for the logger at supplied port
+ (HTTPServer*) httpServerWithPort:(UInt16)port;

- (void)addWebSocket:(IGWebLoggerWebSocket*)webSocket;

- (void)removeWebSocket:(IGWebLoggerWebSocket*)webSocket;

@end
