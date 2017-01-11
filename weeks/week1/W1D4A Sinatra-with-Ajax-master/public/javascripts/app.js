$(document).ready(function() {
  $('#new-thought').on('click', function(event) {
    event.preventDefault();
    var request = $.ajax({
      method: "GET",
      url: "/thoughts/random.json"
    });

    // Upon a successful response, alert with the new thought.
    request.done(function(data) {
      alert(data.thought);
    });
  });

  $('#thing').on('click', function(event) {
    event.preventDefault();
    
    $.ajax({
      method: "GET",
      url: "/items"
    }).done(function(data) {
      console.log(data);
    });
  });
});
