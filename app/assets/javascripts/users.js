$(document).ready( function () {
  $('#user_is_married').change(function(){
    var selected_option = $( "#user_is_married option:selected" ).val();
    if (selected_option === "true") {
      $('#wedding_form').show()
    } else {
      $('#wedding_form').hide()
    }
  });
});
