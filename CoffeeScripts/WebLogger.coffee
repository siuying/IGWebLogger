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

  setFilter: (level) ->
    $("#logger").removeClass("level-error level-warn level-info level-verbose level-all")
    $("#logger").addClass("level-#{level}") if level

$(document).ready ->
  logger = new WebLogger()
  
  $("#clear").on 'click', ->
    $("#logger").html("")
    return false

  $("#level li a").on 'click', (e) ->
    level = $(this).data("level")
    if level
      console.log "set filter to #{level}"
      $("#level li").removeClass("active")
      $(this).parent().addClass("active").addClass("level-#{level}")
      logger.setFilter(level)

    return false

  if `("WebSocket" in window)`
    ws = new WebSocket("%%WEBSOCKET_URL%%")
    ws.onopen = ->
      console.log "connection open"
      logger.setConnected(true)
    ws.onclose = ->
      console.log "connection closed"
      logger.setConnected(false)
    ws.onmessage = (evt) ->
      data = $.parseJSON(evt.data)
      if data.message && data.level
        logger.log data.message, data.level
      else
        console.log "unexpected data: ", evt.data
  else
    alert "Your browser doesn't support WebSocket!"
