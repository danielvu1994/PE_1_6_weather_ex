defmodule Weather.CrawData do
  @user_agent  [ {"User-agent", "daniel"}]

  def fetch_data(loction_Id) do
    url = "https://w1.weather.gov/xml/current_obs/#{loction_Id}.xml"

    HTTPoison.get(url, @user_agent)
    |> handle_response(loction_Id)
  end

  def handle_response({ :ok, %{status_code: status_code, body: body}},loction_Id) do
    #Return tupple
    status = status_code |> check_for_error()
    handle_response_2(status, body, loction_Id)
  end

  def handle_response_2(:error, _body, loction_Id), do: {:error, loction_Id}
  def handle_response_2(:ok, body, _loction_Id) do
    {
      :ok,
      body |> XmlToMap.naive_map()
    }
  end

  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error
end
