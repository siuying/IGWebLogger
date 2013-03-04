//
//  IGWebLogger.m
//  IGWebLogger
//
//  Created by Francis Chong on 13年3月4日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGWebLogger.h"
#import "WebSocket.h"

@implementation IGWebLogger

static IGWebLogger *sharedInstance;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		sharedInstance = [[IGWebLogger alloc] init];
    });
}

+ (IGWebLogger *)sharedInstance
{
	return sharedInstance;
}

- (id)init
{
	if (sharedInstance != nil)
	{
		return nil;
	}
	
	if ((self = [super init]))
	{
        self.webSockets = [NSMutableArray array];
	}

	return self;
}

- (void)logMessage:(DDLogMessage *)logMessage
{
	NSString *logMsg = logMessage->logMsg;
	if (formatter)
	{
		logMsg = [formatter formatLogMessage:logMessage];
	}

	if (logMsg && [self.webSockets count] > 0)
	{
        [self.webSockets enumerateObjectsUsingBlock:^(WebSocket* socket, NSUInteger idx, BOOL *stop) {
            [socket sendMessage:logMsg];
        }];
	}
}

- (void)addWebSocket:(WebSocket*)webSocket
{
    dispatch_sync([DDLog loggingQueue], ^{
        [self.webSockets addObject:webSocket];
    });
}

- (void)removeWebSocket:(WebSocket*)webSocket
{
    dispatch_sync([DDLog loggingQueue], ^{
        [self.webSockets removeObject:webSocket];
    });
}

- (NSString *)loggerName
{
	return @"hk.ignition.logger.IGWebLogger";
}

@end
