module Beer

  # Beer::Number represents a number of bottles on the wall. It uses
  # MODULUS 100 arithmetic and has special knowledge of verses,
  # plurals and other song related phrases.
  class Number
    def initialize(n)
      @value = n
    end

    def pred
      Number.new(@value-1)
    end

    def to_s
      @value.to_s
    end

    def verse
      result = ""
      result << on_the_wall.capitalize << ", "
      result << of_beer << ".\n"
      result << action << ", "
      result << pred.on_the_wall << ".\n"
      result
    end

    protected

    def on_the_wall
      "#{of_beer} on the wall"
    end

    private

    def of_beer
      "#{self} #{bottles} of beer"
    end

    def bottles
      "bottles"
    end

    def action
      "Take #{pronoun} down and pass it around"
    end

    def pronoun
      "one"
    end

    class One < Number
      def initialize
        super(1)
      end

      def bottles
        "bottle"
      end

      def pronoun
        "it"
      end
    end

    class Zero < Number
      def initialize
        super(0)
      end

      def pred
        Number.new(99)
      end

      def to_s
        "no more"
      end

      def action
        "Go to the store and buy some more"
      end
    end

    CACHE = {
      0 => Zero.new,
      1 => One.new,
    }

    def self.new(number)
      CACHE[number] ||= super
    end
  end

  # Beer::Song is the 99 bottles of beer song.
  class Song
    def verse(n)
      Number.new(n).verse
    end

    def verses(start=99, finish=0)
      start.downto(finish).map { |i| verse(i) + "\n" }.join
    end
  end
end

if $0 == __FILE__
  puts Beer::Song.new.verses
end
