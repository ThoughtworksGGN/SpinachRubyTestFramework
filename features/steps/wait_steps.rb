require "timeout"

module WaitSteps
  extend RSpec::Matchers::DSL

  matcher :become do |arg|
    supports_block_expectations
    match do |block|
      begin
        Timeout.timeout(Capybara.default_wait_time) do
          sleep(2) until value = (arg == block.call)
          value
        end
      rescue TimeoutError
        raise Exception.new("'#{block.call}' \n should have been same as \n '#{arg}'")
      end
    end
  end

  matcher :include_text do |arg|
    supports_block_expectations
    match do |block|
      begin
        Timeout.timeout(Capybara.default_wait_time) do
          sleep(2) until value = block.call.include?(arg)
          value
        end
      rescue TimeoutError
        raise Exception.new("'#{block.call}' \n should include \n '#{arg}'")
      end
    end
  end

  matcher :not_include_text do |arg|
    supports_block_expectations
    match do |block|
      begin
        Timeout.timeout(Capybara.default_wait_time) do
          sleep(2) until value = !block.call.include?(arg)
          value
        end
      rescue TimeoutError
        raise Exception.new("'#{block.call}' \n should not include \n '#{arg}'")
      end
    end
  end

  matcher :greater_than do |arg|
    supports_block_expectations
    match do |block|
      begin
        Timeout.timeout(Capybara.default_wait_time) do
          sleep(2) until value = block.call > arg
          value
        end
      rescue TimeoutError
        raise Exception.new("'#{block.call}' \n should be greater than \n '#{arg}'")
      end
    end
  end

  matcher :become_true do
    supports_block_expectations
    match do |block|
      begin
        Timeout.timeout(Capybara.default_wait_time) do
          sleep(2) until value = block.call
          value
        end
      rescue TimeoutError
        false
      end
    end
  end

end
