require 'rspec/given'
require 'beer_song'

module Beer
  V99 =
    "99 bottles of beer on the wall, 99 bottles of beer.\n" +
    "Take one down and pass it around, 98 bottles of beer on the wall.\n"

  V98 =
    "98 bottles of beer on the wall, 98 bottles of beer.\n" +
    "Take one down and pass it around, 97 bottles of beer on the wall.\n"

  V2 =
    "2 bottles of beer on the wall, 2 bottles of beer.\n" +
    "Take one down and pass it around, 1 bottle of beer on the wall.\n"

  V1 =
    "1 bottle of beer on the wall, 1 bottle of beer.\n" +
    "Take it down and pass it around, no more bottles of beer on the wall.\n"

  V0 =
    "No more bottles of beer on the wall, no more bottles of beer.\n" +
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

  describe Number do
    Given(:bn) { Number.new(n) }

    Invariant { bn.pred == Number.new((n+99) % 100) }

    context "with 99" do
      Given(:n) { 99 }
      Then { bn.to_s == '99' }
      Then { bn.verse == V99 }
    end

    context "with 98" do
      Given(:n) { 98 }
      Then { bn.to_s == '98' }
      Then { bn.verse == V98 }
    end

    context "with 2" do
      Given(:n) { 2 }
      Then { bn.to_s == '2' }
      Then { bn.verse == V2 }
    end

    context "with 1" do
      Given(:n) { 1 }
      Then { bn.to_s == '1' }
      Then { bn.verse == V1 }
    end

    context "with 0" do
      Given(:n) { 0 }
      Then { bn.to_s == 'no more' }
      Then { bn.verse == V0 }
    end
  end

  describe Song do
    Given(:bottle) { Song.new }

    def count(string, pattern)
      string.scan(Regexp.new(Regexp.quote(pattern))).size
    end

    context "one verse" do
      When(:result) { bottle.verse(2) }
      Then { result == V2 }
    end

    context "entire song" do
      When(:result) { bottle.verses(99) }
      Then { count(result, V99 + "\n") == 1 }
      Then { count(result, V98 + "\n") == 1 }
      Then { count(result, V2 + "\n") == 1 }
      Then { count(result, V1 + "\n") == 1 }
      Then { count(result, V0 + "\n") == 1 }
    end
  end
end
