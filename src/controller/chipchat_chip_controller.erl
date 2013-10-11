-module(chipchat_chip_controller, [Req]).
-compile(export_all).

chat('POST', []) ->
  Nickname = Req:post_param("nickname"),
  Text     = Req:post_param("text"),
  io:write("nickname is"),
  io:write(Nickname),
  Message  = message:new(id, Text, Nickname, erlang:localtime()),
  boss_mq:push("public", Message),
  { json, [{ success, Nickname }] };

chat('GET', [Nickname]) ->
  { ok, [{ nickname, Nickname }] }.

poll('GET', [Nickname, LastTimestamp]) ->
  {ok, Timestamp, Messages} = boss_mq:pull("public", list_to_integer(LastTimestamp)),
  {json, [{timestamp, Timestamp}, {messages, Messages}]}.
