require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit
  Capybara.default_max_wait_time = 5

  config.include AcceptanceMacros, type: :feature
end