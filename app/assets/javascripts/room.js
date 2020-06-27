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
  	  url: "/room_users/bulk_create",
  	  type: 'POST',
  	  data: {
  	  	      'user_ids': ids,
  	          'room_id': $('#room_id')[0].value,
  	        },
  	  success: function(){
  	  	alert('Users successfully added!');
  	  }
  	});
  });
});