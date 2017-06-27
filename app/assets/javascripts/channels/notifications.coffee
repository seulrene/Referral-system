App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    html = @createLine(data)
    $("#notifications").append(html)

  createLine: (data) ->
    """
    <p>#{data['notification']}</p>
    """

  notify: (notification)->
    @perform 'notify', notification: notification