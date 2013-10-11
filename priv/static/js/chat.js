$(function () {
  $("#new-message").submit(function (e) {
    var $form  = $(this),
        action = $form.attr("action"),
        data   = $form.serialize();

    $.post(action, data, function () {
      $("#text").val("");
    });
    e.preventDefault();
  });

  var pollUrl = $("#messages").data("url");
  var poll = function (timestamp) {
    $.get(pollUrl + "/" + timestamp , function (data) {
      for (var i = 0; i < data.messages.length; i++) {
        var msg = data.messages[i];
        $('.template', "#messages").
          clone().
          removeClass('template').
          text(msg.nickname + ' > ' + msg.body).
          appendTo("#messages");
      };
      $('#messages').each(function () {
        this.scrollTop = this.scrollHeight - 40;
      });
      poll(data.timestamp);
    });
  };
  poll(0);
});
