defmodule PentoWeb.AdminDashboardLiveTest do
  use PentoP2Web.ConnCase

  import Phoenix.LiveViewTest
  alias PentoP2.{Accounts, Survey, Catalog}

  @create_product_attrs %{
    description: "Test description",
    name: "Test name",
    sku: 42,
    unit_price: 120.5
  }

  @create_demo_attrs %{
    gender: "female",
    year_of_birth: DateTime.utc_now().year - 15
  }

  @create_demo_over_18_attrs %{
    gender: "male",
    year_of_birth: DateTime.utc_now().year - 30
  }

  @create_user_attrs %{email: "test@test.com", password: "password"}
  @create_user2_attrs %{email: "test2@test.com", password: "password"}
  @create_user3_attrs %{email: "test3@test.com", password: "password"}

  defp product_fixture do
    {:ok, product} = Catalog.create_product(@create_product_attrs)
    product
  end

  defp user_fixture(attrs \\ @create_user_attrs) do
    {:ok, user} = Accounts.register_user(attrs)
    user
  end

  defp demo_fixture(user, attrs) do
    attrs =
      attrs
      |> Map.merge(%{user_id: user.id})

    {:ok, demo} = Survey.create_demographic(attrs)
    demo
  end

  defp rating_fixture(user, product, stars) do
    {:ok, rating} =
      Survey.create_rating(%{
        stars: stars,
        user: user.id,
        product: product.id
      })

    rating
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  defp create_demo(user, attrs \\ @create_demo_attrs) do
    demo = demo_fixture(user, attrs)
    %{demographic: demo}
  end

  defp create_rating(user, product, stars) do
    rating = rating_fixture(user, product, stars)
    %{rating: rating}
  end

  describe "Survey results" do
    setup [:register_and_log_in_user, :create_product, :create_user]

    setup %{user: user, product: product} do
      create_demo(user)
      create_rating(user, product, 2)

      user2 = user_fixture(@create_user2_attrs)
      create_rating(user2, product, 3)

      :ok
    end
  end

  test "it filters by age group", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin-dashboard")
    params = %{"age_group_filter" => "18 and under"}

    assert view
           |> element("#age_group_form")
           |> render_change(params) =~ "<title>2.0</title>"
  end
end
