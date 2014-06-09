ENV['RAILS_ENV'] = 'test'
require './config/environment'

require 'rspec/rails'

Capybara.app_host = "http://search.yahoo.com/"
Capybara.run_server = false

Dir["#{Rails.root}/features/pages/**/*.rb"].sort.each do |file|
  require file
end

require "#{Rails.root}/features/steps/wait_steps.rb"

Capybara.default_wait_time = 16

Spinach.hooks.before_run do
  case ENV['headless']
    when 'true'
      require 'headless'
      unless ENV['TEST_ENV_NUMBER'].blank?
        display = ENV['TEST_ENV_NUMBER'].to_i + 1
      else
        display = 99
      end
      headless = Headless.new(:display => display, :reuse => false, :dimensions => '1280x1024x16')
      headless.start
      Capybara.default_driver = Capybara.javascript_driver = :webkit
    else
      case ENV['driver']
        when 'chrome'
          Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(app, :browser => :chrome)
          end
        else
          Capybara.default_driver = Capybara.javascript_driver = :selenium
      end
  end
end

# require 'database_cleaner'
# DatabaseCleaner.strategy = :truncation
#
# Spinach.hooks.before_scenario{ DatabaseCleaner.clean }
#
# Spinach.config.save_and_open_page_on_failure = true
