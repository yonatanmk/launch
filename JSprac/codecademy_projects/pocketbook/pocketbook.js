var main = function () {
  $('button').click(function(){
    if ($('input[name="first_name"]').val() === "") {
      $('#first_name_error').text("Please enter a first name");
    }
    else if ($('input[name="first_name"]').val().length < 5) {
      $('#first_name_error').text("First name must be at least 5 characters long");
    }
    else {
      $('#first_name_error').text("");
    }

    if ($('input[name="last_name"]').val() === "") {
      $('#last_name_error').text("Please enter a last name");
    }
    else if ($('input[name="last_name"]').val().length < 5) {
      $('#last_name_error').text("Last name must be at least 5 characters long");
    }
    else {
      $('#last_name_error').text("");
    }

    if ($('input[name="email"]').val() === "") {
      $('#email_error').text("Please enter an email");
    }
    else if ($('input[name="email"]').val().length < 5) {
      $('#email_error').text("Email name must be at least 5 characters long");
    }
    else if (!$('input[name="email"]').val().includes("@")) {
      $('#email_error').text("That is not an email adress");
    }
    else {
      $('#email_error').text("");
    }

    if ($('input[name="password"]').val() === "") {
      $('#password_error').text("Please enter a password");
    }
    else if ($('input[name="password"]').val().length < 5) {
      $('#password_error').text("Password must be at least 5 characters long");
    }
    else {
      $('#password_error').text("");
    }
  });
};

$(document).ready(main);
