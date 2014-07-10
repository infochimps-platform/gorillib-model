require 'bundler/gem_tasks'

task default: [:spec]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

desc 'Run RSpec with code coverage'
task :cov do
  ENV['GORILLIB_MODEL_COV'] = 'true'
  Rake::Task[:spec].execute
end

require 'yard'
YARD::Rake::YardocTask.new
