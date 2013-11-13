module Beer

  class Verse
    attr_reader :number

    def initialize(n)
      @number = n
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

    def pred
      (@number+99) % 100
    end

    def of_beer
      "#{amount} #{bottles} of beer"
    end

    def bottles
      "bottles"
    end

    def pronoun
      "one"
    end

    def amount
      @number.to_s
    end

    def action
      "Take #{pronoun} down and pass it around"
    end

    class WithArglessNew < Verse
      def self.new
        super(:ignore)
      end
    end

    class Zero < WithArglessNew
      def initialize(_)
        super(0)
      end

      def amount
        "no more"
      end

      def action
        "Go to the store and buy some more"
      end
    end

    class One < WithArglessNew
      def initialize(_)
        super(1)
      end

      def bottles
        "bottle"
      end

      def pronoun
        "it"
      end
    end

    PREMADE = {
      0 => Zero.new,
      1 => One.new,
    }

    def self.new(n)
      PREMADE[n] || super(n)
    end
  end

  class Song
    def verses(start, finish=0)
      start.downto(finish).map { |n| verse(n) + "\n" }.join
    end

    def verse(n)
      Verse.new(n).to_s
    end
  end
end
