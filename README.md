## IGWebLogger

IGWebLogger allows you to view your iOS app logs over web browser in realtime.

It is a CocoaLumberjack logger which prints log over websocket connection.

Status: Experimental

### Install

IGWebLogger needs latest version of CocoaHTTPServer which has latest WebSocket and ARC supports. If you
use cocoapods, you will need to include following pods in your ```Podfile```:

```ruby
pod "IGWebLogger", :podspec => "https://raw.github.com/siuying/IGWebLogger/master/IGWebLogger.podspec"
pod "CocoaHTTPServer", :podspec => 'https://gist.github.com/siuying/5080491/raw/a06f5559ee7bc9a6128c1135cfbd2f62d9aded00/CocoaHTTPServer.podspec'
```

### Usage

First, start the web socket server in AppDelegate.m

```objective-c

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // setup logger
  [DDLog addLogger:[IGWebLogger sharedInstance]];

  // setup HTTP server
  self.httpServer = [IGWebLogger httpServer];
  NSError *error;
  if(![self.httpServer start:&error])
  {
      DDLogError(@"Error starting HTTP Server: %@", error);
  }

  return YES;
}
```

Then connects your browser to http://localhost:8888 to view the logs realtime. (replace localhost with your iPhone address, if you run this on real device)

![](https://raw.github.com/siuying/IGWebLogger/master/screen.png)

### Dependency

-  CocoaHTTPServer - use the HEAD version which has latest WebSocket and ARC supports
