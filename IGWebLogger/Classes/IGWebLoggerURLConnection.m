//
//  IGWebLoggerURLConnection.m
//  IGWebLogger
//
//  Created by Francis Chong on 13年3月4日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGWebLoggerURLConnection.h"
#import "HTTPMessage.h"
#import "HTTPResponse.h"
#import "HTTPDynamicFileResponse.h"
#import "GCDAsyncSocket.h"
#import "HTTPLogging.h"
#import "IGWebLoggerWebSocket.h"

static const int httpLogLevel = HTTP_LOG_LEVEL_WARN | HTTP_LOG_FLAG_TRACE;

@implementation IGWebLoggerURLConnection

-(NSObject<HTTPResponse>*) httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    HTTPLogTrace();

    // Replace %%WEBSOCKET_URL%% from websocket.js to the actual URL of the server
    if ([path isEqualToString:@"/js/WebLogger.js"]) {
        NSString *wsLocation;
        NSString *wsHost = [request headerField:@"Host"];
        if (wsHost == nil)
        {
            NSString *port = [NSString stringWithFormat:@"%hu", [asyncSocket localPort]];
            wsLocation = [NSString stringWithFormat:@"ws://localhost:%@/service", port];
        }
        else
        {
            wsLocation = [NSString stringWithFormat:@"ws://%@/service", wsHost];
        }
        
        NSDictionary *replacementDict = [NSDictionary dictionaryWithObject:wsLocation
                                                                    forKey:@"WEBSOCKET_URL"];
        return [[HTTPDynamicFileResponse alloc] initWithFilePath:[self filePathForURI:path]
                                                   forConnection:self
                                                       separator:@"%%"
                                           replacementDictionary:replacementDict];
    }
    return [super httpResponseForMethod:method URI:path];
}

- (WebSocket *)webSocketForURI:(NSString *)path
{
    if([path isEqualToString:@"/service"])
    {
        return [[IGWebLoggerWebSocket alloc] initWithRequest:request socket:asyncSocket];
    }
    return [super webSocketForURI:path];
}


@end
