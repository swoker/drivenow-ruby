require "bundler"
Bundler.setup
$KCODE = 'U' if RUBY_VERSION < '1.9.0'

require 'rake/testtask'

gemspec = eval(File.read("drivenow.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["drivenow.gemspec"] do
  system "gem build drivenow.gemspec"
  system "gem install drivenow-#{Drivenow::VERSION}.gem"
end


Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
