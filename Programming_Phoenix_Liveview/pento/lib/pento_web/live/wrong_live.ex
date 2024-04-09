defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @spec mount(any(), any(), any()) :: {:ok, any()}
  def mount(_params, _session, socket) do
    random_number = Enum.random(1..10)
    {:ok, assign(socket, score: 0, message: "Make a guess:", number_to_guess: random_number, time: time())}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
    <h2>
      <%= @message %> It's <%= @time %>
    </h2>
    <br/>
    <h2>
      <%= for n <- 1..10 do %>
        <.link class="bg-blue-500 hover:bg-blue-700
        text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
        phx-click="guess" phx-value-number= {n} >
            <%= n %>
        </.link>
      <% end %>
    </h2>

    <%= if @message |> String.contains?("win") do %>
      <button phx-click="restart" class="mt-4 bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
        Restart Game
      </button>
    <% end %>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    guess = String.to_integer(guess)

    if guess == socket.assigns.number_to_guess do
      message = "Congratulations! You win! The number was #{guess}."
      score = socket.assigns.score + 1
      {:noreply, assign(socket, message: message, score: score)}
    else
      message = "Your guess: #{guess}. Wrong. Guess again."
      score = socket.assigns.score - 1
      {:noreply, assign(socket, message: message, score: score)}
    end
  end

  def handle_event("restart", _params, socket) do
    random_number = Enum.random(1..10)
    {:noreply, assign(socket, score: 0, message: "Make a guess:", number_to_guess: random_number, time: time())}
  end

  def time() do
    DateTime.utc_now |> to_string
  end
end
