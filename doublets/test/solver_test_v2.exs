defmodule Doublets.SolverTest do
  use ExUnit.Case
  import Doublets.Solver

  test "with word links found" do
    assert ["head", "heal", "teal", "tell", "tall", "tail"] ==
           doublets("head", "tail")

    assert ["door", "boor", "book", "look", "lock"] ==
           doublets("door", "lock")

    assert ["bank", "bonk", "book", "look", "loon", "loan"] ==
           doublets("bank", "loan")

    assert ["wheat", "cheat", "cheap", "cheep", "creep", "creed", "breed", "bread"] ==
           doublets("wheat", "bread")
  end

  test "with no word links found" do
    assert [] == doublets("ye", "freezer")
  end

  test "get the last element of the list" do
    assert "tail" == last_word(["head", "heal", "teal", "tell", "tall", "tail"])
    assert "tail" == last_word(["tail"])
    assert [] == last_word([])
  end

  test "find other words that have the same length" do
    assert ["liken", "impar", "untie", "wheat", "cheat", "cheap", "creep", "creed",
            "breed", "bread"] == same_length_words("cheep")
    assert ["layship", "caroome", "strolld", "outwind", "collyba", "doghead", "dogwood",
            "cumidin", "misally"] == same_length_words("freezer")
    assert ["indiscriminateness"] == same_length_words("ancistrocladaceous")
  end

  test "Computes the distance from one word to another" do
    assert 0 == Solver.distance("cheep", "cheep")
    assert 1 == Solver.distance("head", "heal")
    assert 4 == Solver.distance("cheep", "bread")
  end

  test "variations of a word" do
    assert ["cheep", "creed"] == find_variants("creep") 
    assert ["head", "teal"] == find_variants("heal") 
    assert [] == find_variants("")
  end

  @tag :skip
  test "" do
    assert [] == complete_seq_variants()
  end

  @tag :skip
  test "" do
    assert [] == find_solution()
  end

  @tag :skip
  test "" do
    assert [] == doublets_impl()
  end
  

end
