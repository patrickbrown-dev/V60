require "minitest/autorun"
require "minitest/benchmark"
require "kisoku"

class RulesEngineBenchmark < MiniTest::Benchmark
  class SlowActionRule < Kisoku::Rule
    def condition(params)
      true
    end

    def action(state, params)
      sleep(1)
      state
    end
  end

  class SlowConditionRule < Kisoku::Rule
    def condition(params)
      sleep(1)
      true
    end

    def action(state, params)
      state
    end
  end

  class SlowRulesEngine < Kisoku::RulesEngine
    def reduce(results)
      []
    end
  end

  def bench_conditions
    if ENV["BENCH"]
      assert_performance_linear 0.99 do |n|
        rules_engine = SlowRulesEngine.new
        (1..n).each do
          rules_engine.add_rule SlowConditionRule.new
        end
        rules_engine.run(nil, {})
      end
    end
  end

  def bench_actions
    if ENV["BENCH"]
      assert_performance_power 0.99 do |n|
        rules_engine = SlowRulesEngine.new
        (1..n).each do
          rules_engine.add_rule SlowActionRule.new
        end
        rules_engine.run(nil, {})
      end
    end
  end
end
