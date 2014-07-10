if ENV['GORILLIB_MODEL_COV']
  require 'simplecov'
  SimpleCov.start do
    add_group 'Specs',   'spec/'
    add_group 'Library', 'lib/'
  end
end

require 'gorillib/model'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each{ |f| require f}

RSpec.configure do |config|
  include Gorillib::TestHelpers
end
