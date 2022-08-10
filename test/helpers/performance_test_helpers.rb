require "benchmark/ips"

module PerformanceTestHelpers
  BENCHMARK_DURATION = 1
  BENCHMARK_WARMUP = 1
  BASELINE_LABEL = "Baseline"
  CODE_TO_TEST_LABEL = "Code"

  # Usage:
  #
  #     baseline = -> { <some baseline code> }
  #
  #     assert_slower_by_at_most 2, baseline: baseline do
  #       <the code you want to compare against the baseline>
  #     end
  def assert_slower_by_at_most(threshold_factor, baseline:, baseline_label: BASELINE_LABEL, code_to_test_label: CODE_TO_TEST_LABEL, duration: BENCHMARK_DURATION, quiet: true, &block_to_test)
    GC.start

    result = nil
    output, error = capture_io do
      result = Benchmark.ips do |x|
        x.config(time: duration, warmup: BENCHMARK_WARMUP)
        x.report(code_to_test_label, &block_to_test)
        x.report(baseline_label, &baseline)
        x.compare!
      end
    end

    baseline_result = result.entries.find { |entry| entry.label == baseline_label }
    code_to_test_result = result.entries.find { |entry| entry.label == code_to_test_label }

    times_slower = baseline_result.ips / code_to_test_result.ips

    if !quiet || times_slower >= threshold_factor
      puts "#{output}#{error}"
    end

    assert times_slower < threshold_factor, "Expecting #{threshold_factor} times slower at most, but got #{times_slower} times slower"
  end

  def assert_uses_more_memory_by_at_most(threshold_factor, baseline:, baseline_label: BASELINE_LABEL, code_to_test_label: CODE_TO_TEST_LABEL, duration: BENCHMARK_DURATION, quiet: true, &block_to_test)
    GC.start

    result = nil
    output, error = capture_io do
      result = Benchmark.memory do |x|
        x.report(code_to_test_label, &block_to_test)
        x.report(baseline_label, &baseline)
        x.compare!
      end
    end

    baseline_result = result.entries.find { |entry| entry.label == baseline_label }
    code_to_test_result = result.entries.find { |entry| entry.label == code_to_test_label }

    times_more_memory = baseline_result.measurement.memory.allocated.to_f / baseline_result.measurement.memory.allocated.to_f

    if !quiet || times_more_memory >= threshold_factor
      puts "#{output}#{error}"
    end

    assert times_more_memory < threshold_factor, "Expecting #{threshold_factor} times more memory at most, but got #{times_more_memory} times more memory"
  end
end
