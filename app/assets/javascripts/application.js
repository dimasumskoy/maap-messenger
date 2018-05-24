//= require jquery
//= require rails-ujs
//= require bootstrap-sprockets
//= require messages
//= require users
//= require_tree .

$(function () {
  $('.chat-brand').hover(function () {
    document.getElementById("application-brand").style.color = randomColor();
  }, function() { return })
})