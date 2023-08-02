# frozen_string_literal: true

module V60::Reducers
  class Intersection
    def reduce(sets)
      while sets.length > 1
        threads = []
        sets.each_slice(2) do |tuple|
          threads << Thread.new do
            if tuple.length == 1
              tuple[0]
            else
              tuple[0] & tuple[1]
            end
          end
        end

        sets = threads.map(&:value)
      end

      sets[0]
    end
  end
end
