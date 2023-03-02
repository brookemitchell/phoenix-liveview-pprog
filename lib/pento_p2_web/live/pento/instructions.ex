defmodule PentoP2Web.Pento.Instructions do
  @moduledoc false
  use Phoenix.Component

  def show(assigns) do
    ~H"""
    <section>
     <h1>Welcome to Pento!</h1>
     <p>Place components on the board in the right shape and rotation</p>
    </section>
    """
  end
end
