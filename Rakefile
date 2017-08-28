task default: %w[test]

desc 'runs tests'
task :test do
  bundle exec 'rspec'
end

desc 'runs game'
task :play do
  trap('INT') { exit }
  ruby 'app.rb'
end
