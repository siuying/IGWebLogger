## IGWebLogger

IGWebLogger allows you to view your iOS app logs over web browser in realtime.

It is a CocoaLumberjack logger which prints log over websocket connection.

Status: Just started

### Usage

First, start the web socket server in AppDelegate.m

```objective-c
    [DDLog addLogger:[IGWebLogger sharedInstance]];

    self.httpServer = [[HTTPServer alloc] init];
    [self.httpServer setConnectionClass:[IGWebLoggerURLConnection class]];
    [self.httpServer setType:@"_http._tcp."];
    [self.httpServer setPort:8888];

    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    [self.httpServer setDocumentRoot:webPath];

    NSError *error;
    if(![self.httpServer start:&error])
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }   
```

Then connects your browser to http://localhost:8888 to view the logs realtime. (replace localhost with your iPhone address, if you run this on real device)

![](https://raw.github.com/siuying/IGWebLogger/master/screen.png)

### Dependency

-  CocoaHTTPServer - use the HEAD version which has latest WebSocket and ARC supports
