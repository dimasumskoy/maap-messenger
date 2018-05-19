$(function () {
  $('a.user-profile-link').on('click', function (e) {
    e.preventDefault();
    let userId = $(this).data('userId');
    $(`#user-${userId}-profile`).toggle();
    $('.page-content').toggle();
  })

  $('a.opposed-user-profile-link').on('click', function (e) {
    e.preventDefault();
    $.get($(this).attr('href'), function (user_data) {
      $(`#user-${user_data.id}-profile`).toggle();
      $('.page-content').toggle();
    }, 'json');
  })
})