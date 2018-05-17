#$ ->
#  conversationId = $('.messages').data('conversationId')
#  App.messages = App.cable.subscriptions.create { channel: "MessagesChannel", conversation_id: conversationId },
#    connected: ->
#      console.log('OK')
#
#    disconnected: ->
#
#    received: (data) ->
#      message = $.parseJSON(data)
#      if gon.current_user == undefined or gon.current_user.id != message.user_id
#        $(`div#conversation-${conversationId}`).append singleMessage(message)
#        $('form#new_message textarea').val ''
#        document.getElementById(`message-${message.id}`).scrollIntoView()
