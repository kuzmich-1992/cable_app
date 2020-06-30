$( document.getElementById("room_user_id") ).ready(function() {
   $("#add_users").on('click', function(){
   	    var users = [];
	    $.each($('.user_id'), function(){
	    	var is_added;
	    	is_added = $(this).prev(".is_added")[0].checked;
		    users.push({user_id: $(this)[0].value, is_added: is_added});
		});
        $.ajax({
	      url: " /room_users/" + room_user_id.value + "/create ",
	      data: {users: users},
	      method: 'POST',
	    }).done(function(res){
	      // var userData = JSON.parse(res);
	      // $('#' + userData.id + "-add-member").parent().remove();
	      // $('#member-list').append(memberAppendBuilder(userData));
	    });







   //     	    var userId = $(this).attr("id").split("-")[0];
   //     	    debugger;
   //          var data = {room_user_id: userId};
   //     	    var isChecked = $("input:checkbox").is(":checked")? 1:0; 
			//     $.ajax({
			//       url: " /room_users/"+room_user.id+"/create ",
			//       data: { userId:$("input:checkbox").attr ("room_user_id"), strState:isChecked  },
			//       type: 'POST',
			//     }).done(function(res){
			//       var userData = JSON.parse(res);
			//       $('#' + userData.id + "-add-member").parent().remove();
			//       $('#member-list').append(memberAppendBuilder(userData));
			//     });
			//   });
	});
});


var memberAppendBuilder = function(userData){
   return "<li>" + userData.username + "</li>";
};
			