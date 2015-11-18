require 'rake/testtask'

task default: :test
Rake::TestTask.new do |t|
  t.pattern = "spec/*/*_spec.rb"
end

task :console do
  require 'irb'
  require 'irb/completion'
  Dir[__dir__ + '/models/**/*.rb'].each { |file| require file }
  ARGV.clear
  IRB.start
end
