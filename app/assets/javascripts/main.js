$( document.getElementById("room_user.id") ).ready(function() {
   $("#add_users").on('click', function(){
       $("input:checkbox").change(function() { 
       	    var userId = $(this).attr("id").split("-")[0];
            var data = {room_user_id: userId};
       	    var isChecked = $("input:checkbox").is(":checked")? 1:0; 
			    $.ajax({
			      url: " /room_users/"+room_user.id+"/create ",
			      data: { userId:$("input:checkbox").attr ("room_user_id"), strState:isChecked  },
			      type: 'POST',
			    }).done(function(res){
			      var userData = JSON.parse(res);
			      $('#' + userData.id + "-add-member").parent().remove();
			      $('#member-list').append(memberAppendBuilder(userData));
			    });
			  });
			});
          });


var memberAppendBuilder = function(userData){
   return "<li>" + userData.username + "</li>";
};
			