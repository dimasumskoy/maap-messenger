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

$(document).ready(function() {
    toLastMessage();
    sendByEnter();
    previousMessagesIteration();
});

function toLastMessage() {
    if(window.location.pathname.includes('/me/conversations')) {
        var messages = document.getElementsByClassName('single-message');
        var lastMessage = messages[messages.length - 1];
        document.getElementById(lastMessage.id).scrollIntoView();
    }
}

function sendByEnter() {
    $('textarea#message_body').on('keypress', function (e) {
        if (e.ctrlKey) { $('form .btn').trigger('click'); }
    })
}

function previousMessagesIteration() {
    $('a.previous-messages').on('click', function(e) {
        e.preventDefault();
        var conversationId = $(this).data('conversationId');
        var path = $(this).attr('href');
        var searchParams = path.substring(path.indexOf('?') + 1);
        var iteration_value = parseInt(getQueryVariable(searchParams, 'iteration'));
        var changedHref = path.replace('iteration=' + iteration_value, 'iteration=' + (iteration_value + 1));
        $(this).attr('href', changedHref);
    })
}

function getQueryVariable(path, variable) {
    var vars = path.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] == variable) { return pair[1]; }
    }
    return(false);
}