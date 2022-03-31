defmodule FoxGooseBagOfCorn.Puzzle do
  @moduledoc """
  One of Lewis Carroll's favorite puzzles to ask children
  was the one about the Fox, Goose, and Bag of Corn. It has
  to do with getting them all safely across a river.

  The rules for this puzzle are:

  You must get the fox, goose, and bag of corn safely across the other side of the river
  You can only carry 1 item on the boat across with you.
  The fox cannot be left alone with the goose, (or it will be eaten).
  The goose cannot be left alone with the corn, (or it will be eaten).
  """

  @start_position [[:fox, :goose, :corn, :you], [:boat], []]
  @end_position [[], [:boat], [:fox, :goose, :corn, :you]]
  # I assign them a weight
  @entities [fox: 50, goose: 75, corn: 25, you: 100]

  [[50, 75, 25, 100], [:boat], []] # default
  [[25, 50, 75, 100], [:boat], []] # asc

  # ==> one
  [[100, 75, 50, 25], [:boat], []] # invert
  # if len 4 then pop pop push push
  # else pop push

  # start the algorithm
  # if len(boat) == 3 do a pop
  [[25, 50], [:boat, 100, 75], []] # desc
  [[50, 25], [:boat, 100], [75]] # invert

  # ==> two
  [[25], [:boat, 100, 50], [75]]

  # ==> tree
  [[25], [:boat, 100, 75], [50]] # swap
  [[75], [:boat, 100, 25], [50]]

  [[75], [:boat, 100], [50, 25]]
  [[], [:boat, 100, 75], [50, 25]]
  [[], [:boat], [100, 75, 50, 25]]



  @invalid_positions [[:goose, :corn], [:fox, :goose]]
  def river_crossing_plan(step) do

    IO.inspect(step)

    case step do
      # ----------------------->
      # [:boat, :you, :anything]
      # pop --append ------------------>
      #

      # <-----------------------
      # [:boat, :you, :anything]
      # append ----------------> pop

      # append
      #
      [first_bank, boat, []] ->
        cond do
          Enum.count(first_bank) == 4 ->
            first_bank = first_bank -- [:goose, :you]
            boat = boat ++ [:goose, :you]
            river_crossing_plan([first_bank, boat, []])
          Enum.count(first_bank) == 2 ->
            boat = boat -- [:goose]
            river_crossing_plan([first_bank, boat, [:goose]])
          true ->
            IO.inspect(first_bank)
                []
        end
      [first_bank, boat, last_bank] ->
        first_bank = first_bank -- [:fox]
        boat = boat ++ [:fox]
        last_bank = last_bank -- [:goose]
        last_bank = last_bank ++ [:fox]
        swap([first_bank, boat, last_bank])

      [[], _, _] -> # last iteration
        IO.inspect([step, @end_position])
      _ ->
        IO.puts("Error!")
        IO.inspect(step)

    end
  end


  def max([]), do: []

  def max(list) do
    [max | rest] = list
    Enum.reduce(rest, max, fn i, max ->
      if max < i do
        i
      else
        max
      end
    end)
  end

  # main function
  def river_crossing_plan do
    river_crossing_plan(@start_position)
  end

  defp get_supply(boat) do
    boat -- [:you, :boat]
  end

  def swap([first_bank, boat, last_bank]) do
    cond do
      # swap at last_bank
      Enum.count(last_bank) == 1 and Enum.count(boat) == 3 ->
        supply = get_supply(boat)
        boat = push(boat, pop(last_bank)) -- supply
        [first_bank, boat, supply]
      Enum.count(first_bank) == 1 and Enum.count(boat) == 3 ->
        supply = get_supply(boat)
        boat = push(boat, pop(first_bank)) -- supply
        [supply, boat, last_bank]
    end
  end

  defp to_set(list) when is_list(list), do: Enum.into(list, MapSet.new)
  def step_to_sets(step), do: step |> Enum.map(&to_set/1)

  defp push(lst, item), do: List.insert_at(lst, 0, item) |> List.flatten()
  defp pop(lst), do: List.pop_at(lst, 0)

  @doc """
    Example:
    iex> str_atoms = ":a :b :c"
    iex> FoxGooseBagOfCorn.Puzzle.sigil_H(str_atoms)
    #MapSet<[:a, :b, :c]>
    iex> FoxGooseBagOfCorn.Puzzle.sigil_H("")
    #MapSet<[]>
  """
  def sigil_H(str) do
    str |> String.split(" ")
        |> Enum.filter(&String.length(&1) > 0)
        |> Enum.map(&String.replace(&1,":",""))
        |> Enum.map(&String.to_atom/1)
        |> Enum.into(MapSet.new)
  end
end
