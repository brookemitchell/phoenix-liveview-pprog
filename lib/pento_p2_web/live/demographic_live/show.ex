defmodule PentoP2Web.DemographicLive.Show do
  use Phoenix.{Component, HTML}
  alias PentoP2Web.DemographicLive

  def details(assigns) do
    ~H"""
      <div class="survey-component-container">
        <h2>Demographics: <%= raw "&#x2713" %></h2>
        <ul>
          <li>Gender <%= @demographic.gender %></li>
          <li>Year of birth: <%= @demographic.year_of_birth %></li>
        </ul>
      </div>
    """
  end
end
