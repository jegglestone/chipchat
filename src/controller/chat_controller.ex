defmodule Chipchat.ChatController do
  use Boss.WebController

  get :index, [] do
    :ok
  end

  get :index, [cat] do
    {:output, "Hello, " <> cat <> "!"}
  end

  get :messages, [channel, last_timestamp] do
    {ok, timestamp, ms} = :boss_mq.pull(binary_to_list(channel), binary_to_integer(last_timestamp))
    {:json, [{:timestamp, timestamp}, {:messages, Enum.map(ms, fn(m) -> m.nickname <> ": " <> m.body end)}]}
  end

  post :post, [channel] do
    m = post req
    :boss_mq.push(binary_to_list(channel), m)
    { :json, [{:nickname, m.nickname}, {:body, m.body}] }
  end

  defp post req do
    :message.new(:id, body(req), nickname(req), :erlang.localtime)
  end

  defp body req do
    post_param "message", req
  end

  defp nickname req do
    post_param "nickname", req
  end

  defp post_param name, req do
    name |> binary_to_list |> req.post_param |> list_to_binary
  end

end
