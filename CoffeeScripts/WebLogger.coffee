class WebLogger
  constructor: ->
  
  setConnected: (connected) ->
    @connected = connected
    if connected
      $("#status").text("connected").removeClass("warning")
    else
      $("#status").text("disconnected").addClass("warning")

  log: (message, level='info') ->
    html = $("<div/>").text(message).html()
    $("#logger").append("<p class='#{level} log'>#{html}</p>")

    # scroll to bottom
    div = $("#logger")[0]
    div.scrollTop = div.scrollHeight

$(document).ready ->
  logger = new WebLogger()
  
  $("#clear").on 'click', ->
    $("#logger").html("")

  if `("WebSocket" in window)`
    ws = new WebSocket("%%WEBSOCKET_URL%%")
    ws.onopen = ->
      console.log "connection open"
      logger.setConnected(true)
    ws.onclose = ->
      console.log "connection closed"
      logger.setConnected(false)
    ws.onmessage = (evt) ->
      logger.log evt.data
  else
    alert "Your browser doesn't support WebSocket!"
