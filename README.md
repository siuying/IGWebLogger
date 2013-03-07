## IGWebLogger

IGWebLogger allows you to view your iOS app logs over web browser in realtime.

It is a CocoaLumberjack logger which prints log over websocket connection.

Status: Experimental

### Install

The best way to use IGWebLogger is via CocoaPods. Add following line in your ```Podfile```:

```ruby
pod "IGWebLogger", "~> 0.2.0"
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

Use [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack) as usual to add logs.

```objective-c

DDLogError(@"Broken sprocket detected!");
DDLogVerbose(@"User selected file:%@ withSize:%u", filePath, fileSize);

```

Then connects your browser to [http://localhost:8888](http://localhost:8888) to view the logs realtime. (If you run this on real device, replace ```localhost``` with the device name such as ```http://Meteor.local:8888```)

![](https://raw.github.com/siuying/IGWebLogger/master/screen.png)

### Dependency

- [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack) - A fast & simple, yet powerful & flexible logging framework
- [CocoaHTTPServer](https://github.com/robbiehanson/CocoaHTTPServer) - use the HEAD version which has latest WebSocket and ARC supports
