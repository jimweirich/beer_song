module Beer

  class Verse
    attr_reader :number

    def initialize(number)
      @number = number
    end

    def to_s
      "#{on_the_wall.capitalize}, #{of_beer}.\n" +
        "#{action}, #{next_verse.on_the_wall}.\n"
    end

    def next_verse
      Verse.new(pred)
    end

    protected

    def on_the_wall
      "#{of_beer} on the wall"
    end

    private

    def of_beer
      "#{amount} #{bottles} of beer"
    end

    def action
      "Take #{pronoun} down and pass it around"
    end

    def pred
      number - 1
    end

    def bottles
      "bottles"
    end

    def pronoun
      "one"
    end

    def amount
      number.to_s
    end

    class Special < Verse
      def self.new
        super(:ignore)
      end
    end

    class Zero < Special
      def initialize(_)
        super(0)
      end

      def action
        "Go to the store and buy some more"
      end

      def amount
        "no more"
      end

      def pred
        99
      end
    end

    class One < Special
      def initialize(_)
        super(1)
      end

      def pronoun
        "it"
      end

      def bottles
        "bottle"
      end
    end

    SPECIAL = {
      0 => Zero.new,
      1 => One.new,
    }

    def Verse.new(n)
      SPECIAL[n] || super(n)
    end
  end

  class Song
    def verses(start, finish=0)
      start.downto(finish).map { |i| verse(i) + "\n" }.join
    end

    def verse(n)
      Verse.new(n).to_s
    end
  end
end

if $0 == __FILE__
  puts Beer::Song.new.verses(99)
end
