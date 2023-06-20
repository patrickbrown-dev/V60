# frozen_string_literal: true

module Kisoku
  class IntersectionRule
    def initialize(initial_set, operation, operand, key)
      @fn = translate_operation(operation, operand, key)
      @initial_set = initial_set
    end

    def compute
      @fn.call(@initial_set)
    end

    private

    def translate_operation(operation, operand, key)
      if operation == :==
        ->(set) { set.select { |obj| obj[key] == operand } }
      elsif operation == :>=
        ->(set) { set.select { |obj| obj[key] >= operand } }
      elsif operation == :<=
        ->(set) { set.select { |obj| obj[key] <= operand } }
      elsif operation == :>
        ->(set) { set.select { |obj| obj[key] > operand } }
      elsif operation == :<
        ->(set) { set.select { |obj| obj[key] < operand } }
      else
        raise "Unknown operation #{operation}"
      end
    end
  end
end
