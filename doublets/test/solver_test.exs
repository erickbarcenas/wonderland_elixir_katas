defmodule Doublets.SolverTest do
  use ExUnit.Case
  import Doublets.SolverV2

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
    assert 0 == distance("cheep", "cheep")
    assert 1 == distance("head", "heal")
    assert 4 == distance("cheep", "bread")
  end

  test "variations of a word" do
    assert ["cheep", "creed"] == find_variants("creep") 
    assert ["head", "teal"] == find_variants("heal") 
    assert [] == find_variants("")
  end

  test "given a list of words find variations of the last word" do
    assert [["cheep", "cheap"], ["cheep", "creep"]] == complete_seq_variants(["cheep"])
    assert [["head", "heal", "teal", "tell"]] == complete_seq_variants(["head", "heal", "teal"])
    assert [] == complete_seq_variants([])
  end


  test "given a list of lists returns a list with the solution or else nil" do
    word_seqs_1 = [["bank", "bonk", "book", "look", "loon", "loan"]]
    target_1 = "loan"
    assert ["bank", "bonk", "book", "look", "loon", "loan"] == find_solution(word_seqs_1, target_1)

    word_seqs_2 = [
    ["bank", "bonk", "book", "boor", "door"],
    ["bank", "bonk", "book", "look", "lock"],
    ["bank", "bonk", "book", "look", "loon"]
    ]
    target_2 = "loan"
     assert nil == find_solution(word_seqs_2, target_2)
  end
end
