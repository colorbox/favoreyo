require 'capybara'

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu])
  Capybara::Selenium::Driver.new(app, browser: :remote, url:'http://chrome:4444/wd/hub',  options: options)
end

# Capybara.app_host = "http://web:3000"
Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}"

Capybara.server_host = '0.0.0.0'
Capybara.server_port = '3000'
Capybara.always_include_port = true
Capybara.javascript_driver = :chrome
