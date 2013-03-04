//
//  IGWebLoggerWebSocket.m
//  IGWebLogger
//
//  Created by Francis Chong on 13年3月4日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGWebLoggerWebSocket.h"
#import "IGWebLogger.h"

@implementation IGWebLoggerWebSocket

- (void)didOpen
{
    [super didOpen];
    [[IGWebLogger sharedInstance] addWebSocket:self];
}

- (void)didClose
{
    [[IGWebLogger sharedInstance] removeWebSocket:self];
    [super didClose];
}

@end
