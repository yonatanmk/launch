var counter = 1;

/*
$up = $("<p>Up</p>")
$down = $("<p>Down</p>")
$left = $("<p>Left</p>")
$right = $("<p>Right</p>")
$a = $("<p>A</p>")
$b = $("<p>B</p>")
*/

$(document).ready(function() {
  $(document).keydown(function(key) {
    switch(parseInt(key.which,10)) {
			// Up Arrow Pressed
			case 38:
        switch(counter) {
          case 1:
          case 2:
            counter += 1;
            //$('body').append("<p>Up " + (counter) + "</p>");
            break;
          default:
            counter = 1;
            $('body').empty();
        }
				break;
      // Down Arrow Pressed
      case 40:
        switch(counter) {
          case 3:
          case 4:
            counter += 1;
            //$('body').append("<p>Down " + (counter) + "</p>");
            break;
          default:
            counter = 1;
            $('body').empty();
        }
        break;
      // Left Arrow Pressed
      case 37:
        switch(counter) {
          case 5:
          case 7:
            counter += 1;
            //$('body').append("<p>Left " + (counter) + "</p>");
            break;
          default:
            counter = 1;
            $('body').empty();
        }
        break;
			// Right Arrow Pressed
			case 39:
        switch(counter) {
          case 6:
          case 8:
            counter += 1;
            //$('body').append("<p>Right " + (counter - 1) + "</p>");
            break;
          default:
            counter = 1;
            $('body').empty();
        }
				break;
      // A key Pressed
      case 65:
        switch(counter) {
          case 10:
            counter += 1;
            //$('body').append("<p>A " + (counter) + "</p>");
            break;
          default:
            counter = 1;
            $('body').empty();
        }
        break;
        // B key Pressed
      case 66:
        switch(counter) {
          case 9:
            counter += 1;
            //$('body').append("<p>B " + (counter) + "</p>");
            break;
          default:
            counter = 1;
            $('body').empty();
        }
        break;
        // Enter Pressed
      case 13:
        switch(counter) {
          case 11:
            $('body').addClass('bluth');
            counter += 1;
            break;
          default:
            counter = 1;
            $('body').empty();
            $('body').removeClass('bluth');
        }
        break;
      case 32:
        if (counter > 11) {
          $('body').append("<img src='http://i1061.photobucket.com/albums/t480/ericqweinstein/mario.jpg'/>");
          $('img').draggable();
          $('img').dblclick(function(){
            $(this).effect('explode');
          });
        }
        break;
      default:
        $('body').empty();
  	}
	});
});
