defmodule Weather.CLI do
  import Weather.TableFormatter, only: [ print_table_for_columns: 2 ]
  import Weather.CrawData, only: [fetch_data: 0]

  def main() do
    fetch_data()
    |> get_useful_data
    # |> IO.inspect
    |> print_table_for_columns(["station_id", "location", "temp_c", "wind_degrees"])
  end

  def get_useful_data({:error, _}), do: {:error, "Sorry!! There's no data"}
  def get_useful_data({:ok, map}) do
    %{"current_observation" => current_observation} = map
    %{"#content" => content} = current_observation
    # %{"station_id" => station_id, "location" => location,
    #   "temp_c" => temp_c, "wind_degrees" => wind_degrees } = content
    # [station_id, location, temp_c, wind_degrees]

    [content]
  end
end
