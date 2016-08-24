App.event = App.cable.subscriptions.create "EventChannel",
  connected: ->
    setTimeout =>
      @subscribe()
      $(window).on 'unload', -> window.notificationChannel.unsubscribe()
      $(document).on 'page:change', -> window.notificationChannel.subscribe()
    , 1000

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if -1 != $.inArray(parseInt($.cookie('user_id')), data['user_ids'])
      if $('.event_list').length > 0
        if $('#'+data['date_id']).length > 0
          obj = $('.event_list ul li:first')
          obj.before data['event']
        else
          obj = $('<div></div>');
          obj.attr('id', data['date_id']);
          sub_obj = $('<p></p>');
          sub_obj.text(data['date_id']);
          obj.append(sub_obj);
          $('.event_list ul').prepend obj;
          sub_obj.after data['event'];

  subscribe: ->
    @perform 'subscribed'

  unsubscribe: ->
    @perform 'unsubscribed'
