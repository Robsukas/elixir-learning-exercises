defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component
  use PentoWeb, :chart_live

  alias Pento.Catalog

  def update(assigns, socket) do
    {:ok,
      socket
      |> assign(assigns)
      |> assign_gender_filter()
      |> assign_age_group_filter()
      |> assign_products_with_average_ratings()
      |> assign_dataset()
      |> assign_chart()
      |> assign_chart_svg()}
  end

  def handle_event(
      "age_group_filter",
      %{"age_group_filter" => age_group_filter},
      socket
    ) do
      {:noreply,
        socket
        |> assign_age_group_filter(age_group_filter)
        |> assign_products_with_average_ratings()
        |> assign_dataset()
        |> assign_chart()
        |> assign_chart_svg()}
  end

  def handle_event(
    "gender_filter",
    %{"gender_filter" => gender_filter},
    socket
  ) do
    {:noreply,
      socket
      |> assign_gender_filter(gender_filter)
      |> assign_products_with_average_ratings()
      |> assign_dataset()
      |> assign_chart()
      |> assign_chart_svg()
    }
  end

  def assign_age_group_filter(socket) do
    socket
    |> assign(:age_group_filter, "all")
  end

  def assign_age_group_filter(socket, age_group_filter) do
    assign(socket, :age_group_filter, age_group_filter)
  end

  def assign_gender_filter(socket) do
    socket
    |> assign(:gender_filter, "all")
  end

  def assign_gender_filter(socket, gender_filter) do
    assign(socket, :gender_filter, gender_filter)
  end

  defp assign_products_with_average_ratings(socket) do
    filters = %{
      age_group_filter: socket.assigns.age_group_filter,
      gender_filter: socket.assigns.gender_filter
    }

    assign(
      socket,
      :products_with_average_ratings,
      get_products_with_average_ratings(filters)
    )
  end

  defp get_products_with_average_ratings(filters) do
    result = Catalog.products_with_average_ratings(filters)

    case result do
      [] ->
        Catalog.products_with_zero_ratings()
      products ->
        products
    end
  end

  def assign_dataset(
        %{assigns: %{
          products_with_average_ratings: products_with_average_ratings}
        } = socket) do
    socket
    |> assign(
        :dataset,
        make_bar_chart_dataset(products_with_average_ratings)
      )
  end

  defp assign_chart(%{assigns: %{dataset: dataset}} = socket) do
    socket
    |> assign(:chart, make_bar_chart(dataset))
  end

  def assign_chart_svg(%{assigns: %{chart: chart}} = socket) do
    socket
    |> assign(
      :chart_svg,
      render_bar_chart(chart, title(), subtitle(), x_axis(), y_axis())
    )
  end

  defp title do
    "Survey results"
  end

  defp subtitle do
    "Average star ratings for products"
  end

  defp x_axis do
    "product"
  end

  defp y_axis do
    "stars"
  end
end
