$( document.getElementById("room_user_id") ).ready(function() {
   $("#add_users").on('click', function(){
   	    var users = [];
	    $.each($('.user_id'), function(){
	    	var is_added;
	    	is_added = $(this).prev(".is_added")[0].checked = true;
		    users.push({user_id: $(this)[0].value, is_added: is_added});
		});
        $.ajax({
	      url: " /room_users/" + room_user_id.value + "/create ",
	      data: {users: users},
	      method: 'POST',
	    }).done(function(res){
	      
	    });

	});
    
});

$( document.getElementById("room_user_id") ).ready(function() {
   $("#delete_users").on('click', function(){
   	    var users = [];
	    $.each($('.member_user_id'), function(){
	    	var is_deleted;
	    	is_deleted = $(this).prev(".is_deleted")[0].checked = true;
		    users.push({user_id: $(this)[0].value, is_deleted: is_deleted});
		});
        $.ajax({
	      url: " /room_users/" + room_user_id.value + "/destroy ",
	      data: {users: users},
	      method: 'POST',
	    }).done(function(res){
	      
	    });

	});
    
});


var memberAppendBuilder = function(userData){
   return "<li>" + userData.username + "</li>";
};
			
