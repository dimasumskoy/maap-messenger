$(function () {
  $('a.user-profile').on('click', function (e) {
    e.preventDefault();
    let userId = $(this).data('userId');
    $(`#user-${userId}-profile`).toggle();
    $('.page-content').toggle();
  })

// $('a.user-profile').on('click', function(e) {
//   e.preventDefault();
//   $.get($(this).attr('href'), function (data) {
//     console.log(data);
//   }, 'json');
// })
})