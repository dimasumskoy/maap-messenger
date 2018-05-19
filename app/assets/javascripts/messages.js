$(function () {
  toLastMessage();
  sendByEnter();

  let previousMessagesClickCount = 0;

  $('a.previous-messages').on('click', function (e) {
    e.preventDefault();
    previousMessagesClickCount += 1;
    previousMessagesIteration($(this), previousMessagesClickCount);
  });

  function previousMessagesIteration(link, count) {
    let conversationId = link.data('conversationId');
    let range = link.data('range');
    let conversationField = $(`div#conversation-${conversationId}`);
    let previousMessagesLink = $('a.previous-messages');
    $.get({
      url: `/conversation/messages_portion?conversation_id=${conversationId}&iteration=${count}&range=${range}`,
      data: link.serialize(),
      success: function (response, status, xhr) {
        let messages = response.reverse();
        $.each(messages, function (index, message) {
          if (gon.current_user === void 0 || gon.current_user.id !== message.user_id) {
            conversationField.prepend(singleMessage(message, 'opposed-user-message'));
          } else {
            conversationField.prepend(singleMessage(message, 'current-user-message'));
          }
        });
        conversationField.prepend(previousMessagesLink);
      }
    })
  }

  $('form#new_message').on('submit', function (e) {
    e.preventDefault();
    let form = $(this);
    let messageBody = form.serialize();
    $.post(form.attr('action'), messageBody, function (data) {
      if (data.body === '') {
        $('textarea#message_body').focus();
      } else {
        $(`div#conversation-${data.conversation_id}`).append(singleMessage(data, 'current-user-message'));
        $('form#new_message textarea').val('');
        document.getElementById(`message-${data.id}`).scrollIntoView();
      }
    })
  });

  let conversationId = $('.messages').data('conversationId');
  App.messages = App.cable.subscriptions.create({
    channel: "MessagesChannel",
    conversation_id: conversationId
  }, {
    connected: function() {
      return console.log('OK');
    },
    disconnected: function() {},
    received: function(data) {
      let message = $.parseJSON(data);
      if (gon.current_user === void 0 || gon.current_user.id !== message.user_id) {
        $(`div#conversation-${conversationId}`).append(singleMessage(message, 'opposed-user-message'));
        return document.getElementById(`message-${message.id}`).scrollIntoView();
      }
    }
  });
});

const toLastMessage = () => {
  if (window.location.pathname.includes('/me/conversations')) {
    let messages = document.getElementsByClassName('single-message');
    let lastMessage = messages[messages.length - 1];
    document.getElementById(lastMessage.id).scrollIntoView();
  }
};

const sendByEnter = () => {
  $('textarea#message_body').on('keypress', function (e) {
    if (e.ctrlKey) {
      $('form .btn').trigger('click');
    }
  })
};

function singleMessage(message, user) {
  return `<div class="single-message" id="message-${message.id}">
            <div class="sender-name">
              <a href="/users/${message.user_id}">${message.user_username}</a>
            </div>
              <p class="message-body ${user}">${message.body}</p>
          </div>`
}
