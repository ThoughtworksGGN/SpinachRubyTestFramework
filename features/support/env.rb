
require 'rspec'
require 'capybara'
require 'pry'
require 'capybara-page-object'
require 'rspec/expectations'


Capybara.app_host   = "http://search.yahoo.com/"
Capybara.run_server = false

Dir["features/pages/*.rb"].sort.each do |file|
  file = "../../" + file
  require_relative file
end

require_relative '../../features/steps/wait_steps.rb'

Capybara.default_wait_time = 16

Spinach.hooks.before_run do
  case ENV['headless']
    when 'true'
      require 'capybara/poltergeist'
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, { js_errors: false, port: 44678+ENV['TEST_ENV_NUMBER'].to_i, phantomjs_options: ['--proxy-type=none'], timeout: 180 })
      end
      Capybara.default_driver = Capybara.javascript_driver = :poltergeist
    else
      case ENV['driver']
        when 'chrome'
          Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(app, :browser => :chrome)
          end
          Capybara.default_driver = Capybara.javascript_driver = :selenium

        when 'ie'
          caps = {
              :browserName => "internet explorer",
              :version => "9",
              :platform => "ANY",
          }
          Capybara.register_driver :ie do |app|
            Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://localhost:4411/wd/hub", desired_capabilities: caps)
          end
          Capybara.default_driver = Capybara.javascript_driver = :ie

        when 'safari'
          Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(app, :browser => :safari)
          end
          Capybara.default_driver = Capybara.javascript_driver = :selenium

        when 'iphone'
          caps = {
              :browserName => "iphone", #or iPad
              :version => "7.1",
              :platform => "MAC",
              :simulator => true
          }
          client = Selenium::WebDriver::Remote::Http::Default.new
          client.timeout = 1400
          Capybara.register_driver :iphone do |app|
            Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://localhost:5555/wd/hub", http_client: client, desired_capabilities: caps)
          end
          Capybara.default_driver = Capybara.javascript_driver = :iphone

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
