module Beer

  class Verse
    def self.make(n)
      if n == 1
        One.new
      else
        new(n)
      end
    end

    def initialize(n)
      @number = n
    end

    def to_s
      "#{on_the_wall.capitalize}, #{of_beer}.\n" +
        "#{action}, #{next_verse.on_the_wall}.\n"
    end

    def next_verse
      Verse.make(pred)
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
      @number == 1 ? "bottle" : "bottles"
    end

    def pronoun
      @number == 1 ? "it" : "one"
    end

    def amount
      @number == 0 ? "no more" : @number.to_s
    end

    def action
      if @number == 0
        "Go to the store and buy some more"
      else
        "Take #{pronoun} down and pass it around"
      end
    end

    class One < Verse
      def self.new
        super(:ignore)
      end

      def initialize(_)
        super(1)
      end
    end
  end

  class Song
    def verses(start, finish=0)
      start.downto(finish).map { |n| verse(n) + "\n" }.join
    end

    def verse(n)
      Verse.make(n).to_s
    end
  end
end
