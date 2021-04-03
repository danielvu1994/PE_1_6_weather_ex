defmodule Weather.CLI do
  import Weather.TableFormatter, only: [print_table_for_columns: 2]
  import Weather.CrawData, only: [fetch_data: 1]

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of weather in US states in https://w1.weather.gov
  """

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.
  Return a list of `[station_id1, station_id2...]`, or `:help` if help was given.
  """
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.
  Return a list of `[station_id1, station_id2...]`, or `:help` if help was given.
  """
  @spec parse_args(list()) :: list()
  def parse_args(argv) do
    OptionParser.parse(argv,
      switches: [help: :boolen],
      aliaes: [h: :help]
    )
    # This will return empty [] if user type --help or -h
    |> elem(1)
  end

  @doc """
    Process the list and print data table or print help if user ask
  """
  def process([]) do
    IO.puts("""
    useage: weather <location_id_1> <location_id_2> ...
    """)
  end

  def process(location_list) do
    location_list
    |> Enum.map(&fetch_data(&1))
    |> Enum.map(&get_useful_data(&1))
    |> print_table_for_columns(["station_id", "location", "temp_c", "wind_degrees"])
  end

  @doc """
    Get data from struct
    Return dummy map if station ID is wrong
  """
  def get_useful_data({:error, location_id}) do
    %{
      "station_id" => location_id,
      "location" => "Err.No such id",
      "temp_c" => "--------",
      "wind_degrees" => "-------"
    }
  end

  def get_useful_data({:ok, map}, _location_id) do
    %{"current_observation" => current_observation} = map
    %{"#content" => content} = current_observation

    content
  end
end
