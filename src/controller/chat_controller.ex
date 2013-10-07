defmodule Chipchat.ChatController do
  use Boss.WebController

  get :index, [] do
    {:output, "Hello, world!"}
  end

  get :index, [cat] do
    {:output, "Hello, " <> cat <> "!"}
  end

  get :about, [] do
    {:output, "Hello, world!"}
  end

end
