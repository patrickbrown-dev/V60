# frozen_string_literal: true

module V60::Reducers
  class Intersection
    def reduce(sets)
      while sets.length > 1
        threads = []
        sets.each_slice(2) do |tuple|
          threads << if tuple.length == 1
            Thread.new { tuple[0] }
          else
            Thread.new { tuple[0] & tuple[1] }
          end
        end

        sets = threads.map(&:value)
      end

      sets[0]
    end
  end
end
