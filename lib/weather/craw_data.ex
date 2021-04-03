defmodule Weather.CrawData do
  @user_agent  [ {"User-agent", "daniel"}]

  def fetch_data() do
    url = "https://w1.weather.gov/xml/current_obs/KDTO.xml"

    HTTPoison.get(url, @user_agent)
    |> IO.inspect
    |> handle_response()
    |> IO.inspect
  end

  def handle_response({ :ok, %{status_code: status_code, body: body}}) do
    #Return tupple
    {
      status_code |> check_for_error(),
      body |> XmlToMap.naive_map()
    }
  end

  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error
end
