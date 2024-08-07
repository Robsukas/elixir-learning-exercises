defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias PentoWeb.SurveyLive.Component
  alias Pento.{Survey, Catalog}
  alias PentoWeb.{DemographicLive, Endpoint}
  alias PentoWeb.RatingLive.Show

  @survey_results_topic "survey_results"

  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign_demographic()
    |> assign_products()}
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_info({:created_rating, updated_product, product_index}, socket) do
    {:noreply, handle_rating_created(socket, updated_product, product_index)}
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end

  def handle_rating_created(
    %{assigns: %{products: products}} = socket,
    updated_product,
    product_index) do
      Endpoint.broadcast(@survey_results_topic, "rating_created", %{})

      socket
      |> put_flash(:info, "Rating submitted successfully") |> assign(
        :products,
        List.replace_at(products, product_index, updated_product)
      )
  end

  def assign_products(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :products, list_products(current_user))
  end

  def product_rating(assigns) do
    ~H"""
      <div><%= @product.name %></div>
      <%= if rating = List.first(@product.ratings) do %>
        <Show.stars rating={rating} />
      <% else %>
        <h3><%= @product.name %> rating form coming soon!</h3>
      <% end %>
    """
  end

  defp list_products(user) do
    Catalog.list_products_with_user_rating(user)
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}}=socket) do
    assign(socket,
      :demographic,
      Survey.get_demographic_by_user(current_user))
  end
end
