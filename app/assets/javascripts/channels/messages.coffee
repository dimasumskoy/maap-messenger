$ ->
  conversationId = $('.messages').data('conversationId')
  App.messages = App.cable.subscriptions.create { channel: "MessagesChannel", conversation_id: conversationId },
    connected: ->
      console.log('OK')

    disconnected: ->

    received: (data) ->
      message = $.parseJSON(data)
      console.log(message)
