$( document ).ready(function() {
  $('#add-users input').on ('click', function(){
    var userId = $(this).attr("id").split("-")[0];
    var data = {user_id: userId};
    $.ajax({
      url: " /room_users/room_user.id/create ",
      data: { "user_id": userId, },
      type: 'POST',
    }).done(function(res){
      var userData = JSON.parse(res);
      $('#' + userData.id + "-add-member").parent().remove();
      $('#member-list').append(memberAppendBuilder(userData));
    });
  });
});

var memberAppendBuilder = function(userData){
   return "<li>" + userData.username + "</li>";
};