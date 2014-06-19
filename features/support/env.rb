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
      require 'capybara/poltergeist'
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {js_errors: false, port:44678+ENV['TEST_ENV_NUMBER'].to_i, phantomjs_options:['--proxy-type=none'], timeout:180})
      end
      Capybara.default_driver = Capybara.javascript_driver = :poltergeist
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
