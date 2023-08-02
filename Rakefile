require "minitest/test_task"
require "rake/testtask"

Minitest::TestTask.create

Rake::TestTask.new(:bench) do |t|
  t.libs = ["lib", "test"]
  t.pattern = "test/**/*_benchmark.rb"
end

task default: :test
