var main = function () {
  $("input[name='top_text']").keyup(function(){
    var top = $(this).val();
    $('.top_row').text(top);
  });

  $("input[name='bot_text']").keyup(function(){
    bot = $(this).val();
    $('.bot_row').text(bot);
  });

  $("input[name='img_source']").keyup(function(){
    source = $(this).val();
    $('#background_image').attr('src', source);
  });
};

$(document).ready(main);












































// var main = function() {
//
//   $('input[name=top_text]').keyup(function() {
//     var top = $(this).val();
//     $('.top-row').text(top.toUpperCase());
//   });
//
//   $('input[name=bot_text]').keyup(function() {
//     var bot = $(this).val();
//     $('.bot-row').text(bot.toUpperCase());
//   });
//
//   $('input[name=img_source]').keyup(function() {
//     var source = $(this).val();
//     $('#background_image').attr('src',source);
//   });
//
// };
