(function() {
  var WebLogger;

  WebLogger = (function() {

    function WebLogger() {}

    WebLogger.prototype.setConnected = function(connected) {
      this.connected = connected;
      if (connected) {
        return $("#status").text("connected").removeClass("warning");
      } else {
        return $("#status").text("disconnected").addClass("warning");
      }
    };

    WebLogger.prototype.log = function(message, level) {
      var div, html;
      if (level == null) {
        level = 'info';
      }
      html = $("<div/>").text(message).html();
      $("#logger").append("<p class='" + level + " log'>" + html + "</p>");
      div = $("#logger")[0];
      return div.scrollTop = div.scrollHeight;
    };

    return WebLogger;

  })();

  $(document).ready(function() {
    var logger, ws;
    logger = new WebLogger();
    $("#clear").on('click', function() {
      return $("#logger").html("");
    });
    if (("WebSocket" in window)) {
      ws = new WebSocket("%%WEBSOCKET_URL%%");
      ws.onopen = function() {
        console.log("connection open");
        return logger.setConnected(true);
      };
      ws.onclose = function() {
        console.log("connection closed");
        return logger.setConnected(false);
      };
      return ws.onmessage = function(evt) {
        return logger.log(evt.data);
      };
    } else {
      return alert("Your browser doesn't support WebSocket!");
    }
  });

}).call(this);
