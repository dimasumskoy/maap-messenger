// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function () {
  let previousMessagesClickCount = 0;

  toLastMessage();
  sendByEnter();

  $('a.previous-messages').on('click', function (e) {
    e.preventDefault();
    previousMessagesClickCount += 1;
    previousMessagesIteration($(this), previousMessagesClickCount);
  })
});

function toLastMessage() {
  if (window.location.pathname.includes('/me/conversations')) {
    let messages = document.getElementsByClassName('single-message');
    let lastMessage = messages[messages.length - 1];
    document.getElementById(lastMessage.id).scrollIntoView();
  }
}

function sendByEnter() {
  $('textarea#message_body').on('keypress', function (e) {
    if (e.ctrlKey) {
      $('form .btn').trigger('click');
    }
  })
}

function previousMessagesIteration(link, count) {
  let conversationId = link.data('conversationId');
  let range = link.data('range');
  $.get({
    url: `/conversation/messages_portion?conversation_id=${conversationId}&iteration=${count}&range=${range}`,
    data: link.serialize(),
    success: function(response, status, xhr) {
      console.log(response)
    }
  })
}
