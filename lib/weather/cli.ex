defmodule Weather.CLI do
  import Weather.TableFormatter, only: [ print_table_for_columns: 2 ]
  import Weather.CrawData, only: [fetch_data: 1]

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def process(:help) do
    IO.puts """
    useage: weather <location_id_1> <location_id_2> ...
    """
  end
  def process(location_list) do
    location_list
    |> Enum.map(&fetch_data(&1))
    |> Enum.map(&get_useful_data(&1))
    |> print_table_for_columns(["station_id", "location", "temp_c", "wind_degrees"])
  end

  def get_useful_data({:error, location_id})  do
    %{"station_id" => location_id, "location" => "Err.No such id",
      "temp_c" => "--------", "wind_degrees" => "-------" }
  end
  def get_useful_data({:ok, map}) do
    %{"current_observation" => current_observation} = map
    %{"#content" => content} = current_observation
    # %{"station_id" => station_id, "location" => location,
    #   "temp_c" => temp_c, "wind_degrees" => wind_degrees } = content
    # [station_id, location, temp_c, wind_degrees]

    content
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [ help: :boolen],
                             aliaes: [h: :help])
    |> elem(1)
    |> args_to_location_list
  end

  def args_to_location_list([]) do
    :help
  end
  def args_to_location_list(list), do: list

end
