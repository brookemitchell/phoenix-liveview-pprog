defmodule PentoP2Web.DemographicLive.Show do
  use Phoenix.{Component, HTML}
  alias Phoenix.LiveView.JS

  def toggle_modal(js \\ %JS{}) do
    js
    |> JS.toggle(to: "#demo-section")
    |> JS.remove_class(
      "expanded",
      to: "#button.expanded"
    )
    |> JS.add_class(
      "expanded",
      to: "#button:not(.expanded)"
    )
  end

  def details(assigns) do
    ~H"""
      <div class="survey-component-container">
        <h2>Demographics: <%= raw "&#x2713" %></h2>
        <button
          class="button button-outline"
          id="button"
          phx-value="show"
          phx-click={toggle_modal()}
          />
        <div id="demo-section" class="" >
          <ul>
            <li>Gender <%= @demographic.gender %></li>
            <li>Year of birth: <%= @demographic.year_of_birth %></li>
          </ul>
        </div>
      </div>
    """
  end
end
