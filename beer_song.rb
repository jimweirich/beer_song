module Beer
  class Song
    def verses(start, finish=0)
      start.downto(finish).map { |n| verse(n) + "\n" }.join
    end

    def verse(n)
      "#{on_the_wall(n).capitalize}, #{of_beer(n)}.\n" +
        "#{action(n)}, #{on_the_wall(pred(n))}.\n"
    end

    private

    def pred(n)
      (n+99) % 100
    end

    def on_the_wall(n)
      "#{of_beer(n)} on the wall"
    end

    def of_beer(n)
      "#{amount(n)} #{bottles(n)} of beer"
    end

    def bottles(n)
      n == 1 ? "bottle" : "bottles"
    end

    def pronoun(n)
      n == 1 ? "it" : "one"
    end

    def amount(n)
      n == 0 ? "no more" : n.to_s
    end

    def action(n)
      if n == 0
        "Go to the store and buy some more"
      else
        "Take #{pronoun(n)} down and pass it around"
      end
    end

  end
end
