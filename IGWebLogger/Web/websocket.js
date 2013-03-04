function WebSocketSetup()
{
    if ("WebSocket" in window)
    {
        var ws = new WebSocket("%%WEBSOCKET_URL%%");
        ws.onopen = function() { console.log("websocket is open"); };
        ws.onmessage = function(evt) { console.log("received: " + evt.data); };
        ws.onclose = function() { console.log("websocket is closed"); };
    }
    else
    {
        alert("Browser doesn't support WebSocket!");
    }
}