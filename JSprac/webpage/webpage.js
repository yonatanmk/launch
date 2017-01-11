document.write('<ul><li><a href="http://bbc.co.uk" target="_blank">BBC</a></li> \
<li><a href="http://uk.yahoo.com/?p=us" target="_blank">Yahoo</a></li></ul>');

function change() {
  var x = document.getElementById("name").value;
  if (x != "") {
    document.getElementById("para").innerHTML="Hello " + x + " and welcome to my website.";
    document.getElementById("name").disabled=true;
    document.getElementById("button").disabled=true;
  }
  else {
    alert("Please enter your name into the text box")
  }
}

function greetingMessage() {
  var d = new Date();

  var day = new Array();
  day[0] = "Sunday";
  day[1] = "Monday";
  day[2] = "Tuesday";
  day[3] = "Wednesday";
  day[4] = "Thursday";
  day[5] = "Friday";
  day[6] = "Saturday";

  var date = day[d.getDay()];

  var time = d.getHours();

  if (time < 12) {
    document.getElementById("greeting").innerHTML="Good morning. Today is " + date + "!";
  }
  else if (time < 18) {
    document.getElementById("greeting").innerHTML="Good afternoon. Today is " + date + "!";
  }
  else {
    document.getElementById("greeting").innerHTML="Good evening. Today is " + date + "!";
  }
}
