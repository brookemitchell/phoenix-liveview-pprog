defmodule PentoP2Web.SurveyLive.SurveyResultsLiveTest do
  use PentoP2.DataCase
  alias PentoP2Web.Admin.SurveyResultsLive
  alias PentoP2.{Accounts, Survey, Catalog}

  @create_product_attrs %{
    description: "Test description",
    name: "Test name",
    sku: 42,
    unit_price: 120.5
  }

  @create_user_attrs %{
    email: "test@test.com",
    password: "password"
  }

  @create_user_attrs_2 %{
    email: "another_one@test.com",
    password: "another_password"
  }

  @create_demo_attrs %{
    gender: "female",
    year_of_birth: DateTime.utc_now().year - 30
  }

  @create_demo_2_attrs %{
    gender: "male",
    year_of_birth: DateTime.utc_now().year - 15
  }

  defp product_fixture do
    {:ok, product} = Catalog.create_product(@create_product_attrs)
    product
  end

  defp user_fixture(attrs \\ @create_user_attrs) do
    {:ok, user} = Accounts.register_user(attrs)
    user
  end

  defp demo_fixture(user, attrs \\ @create_demo_attrs) do
    attrs =
      attrs
      |> Map.merge(%{user_id: user.id})

    {:ok, demo} = Survey.create_demographic(attrs)
    demo
  end

  defp rating_fixture(stars, user, product) do
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

  defp create_rating(stars, user, product) do
    rating = rating_fixture(stars, user, product)
    %{rating: rating}
  end

  defp create_demo(user) do
    demo = demo_fixture(user)
    %{demographic: demo}
  end

  defp create_socket(_) do
    %{socket: %Phoenix.LiveView.Socket{}}
  end

  describe "Socket state" do
    setup [:create_user, :create_product, :create_socket]

    setup %{user: user} do
      create_demo(user)
      user2 = user_fixture(@create_user_attrs_2)
      demo_fixture(user2, @create_demo_2_attrs)
      [user2: user2]
    end
  end

  test "No ratings exist", %{socket: socket} do
    socket =
      socket
      |> SurveyResultsLive.assign_age_group_filter()
      |> SurveyResultsLive.assign_gender_filter()
      |> SurveyResultsLive.assign_products_with_average_ratings()

    assert socket.assigns.products_with_average_ratings == ["Test game", 0]
  end

  test "ratings exist", %{socket: socket, product: product, user: user} do
    create_rating(2, user, product)

    socket =
      socket
      |> SurveyResultsLive.assign_age_group_filter()
      |> SurveyResultsLive.assign_gender_filter()
      |> SurveyResultsLive.assign_products_with_average_ratings()

    assert socket.assigns.products_with_average_ratings == ["Test game", 2.0]
  end

  test "ratings are filtered by age group", %{
    socket: socket,
    user: user,
    product: product,
    user2: user2
  } do
    create_rating(2, user, product)
    create_rating(3, user2, product)

    socket =
      socket
      |> SurveyResultsLive.assign_age_group_filter()
      |> assert_keys(:age_group_filter, "all")
      |> update_socket(:age_group_filter, "18 and under")
      |> SurveyResultsLive.assign_age_group_filter()
      |> assert_keys(:products_with_average_ratings, [{"Test game", 2.0}])
  end

  defp update_socket(socket, key, map) do
    %{socket | assigns: Map.merge(socket.assigns, Map.new([{key, value}]))}
  end

  defp assert_keys(socket, key, value) do
    assert socket.assigns[key] == value
    socket
  end
end
