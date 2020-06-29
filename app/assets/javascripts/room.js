$(function() {
  $('#new_room_message').on('ajax:success', function(a, b,c ) {
    $(this).find('input[type="text"]').val('');
  });
});

$(document).on(function() {

  var ids = [];

  $("#add_users").on('click', function(){
    $(':checkbox:checked').map(function(key, value) { ids.push(value.id.split("_")[2]) })
    $.ajax({
      url: "/room_users/create",
      type: 'PUT',
      data: {
              'user_ids': ids,
              'chat_id': $('#chat_id')[0].value,
            },
      success: function(){
        alert('Users successfully added!');
      } }).done(function(res){
      var userData = JSON.parse(res);
      $('#' + userData.id + "-add-member").parent().remove();
      $('#member-list').append(memberAppendBuilder(userData));
      });
    });
  });
  

  var memberAppendBuilder = function(userData){
     return "<li>" + userData.username + "</li>";
  };