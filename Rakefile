require_relative './app.rb'

task default: %w[test]

desc 'runs tests'
task :test do
  bundle exec 'rspec'
end

desc 'runs game'
task :play do
  begin
    initializer(3, 'X', 'O')
  rescue SignalException
  end
end
