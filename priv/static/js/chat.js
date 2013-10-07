$(function () {
  $("#chat").submit(function (e) {
    var $form  = $(this),
        action = $form.attr("action"),
        data   = $form.serialize();

    $.post(action, data);
    e.preventDefault();
  });

  var pollUrl = $("#messages").data("url");
  var poll;
  poll = function (timestamp) {
    $.get(pollUrl + "/" + timestamp, function (data) {
      for (var i = 0; i < data.messages.length; i++) {
        var msg = data.messages[i];
        $('.template', "#messages").
          clone().
          removeClass('template').
          text(msg).
          appendTo("#messages");
      };
        poll(data.timestamp);
    });
  }(0);
});
