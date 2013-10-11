-module(chipchat_login_controller, [Req]).
-compile(export_all).

index('GET', []) ->
  ok;

index('POST', []) ->
  Nickname = Req:post_param("nickname"),
  Text     = string:concat(Nickname, " has joined the room"),
  Message  = message:new(id, Text, Nickname, erlang:localtime()),
  boss_mq:push("public", Message),
  { redirect, string:concat("/chip/chat/", Nickname) }.
